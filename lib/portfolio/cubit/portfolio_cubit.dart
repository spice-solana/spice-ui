import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_web3/programs.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/adapter/cubit/adapter_cubit.dart';
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/pool_pda.dart';
import 'package:spice_ui/models/portfolio.dart';
import 'package:spice_ui/models/provider_pda.dart';
import 'package:spice_ui/portfolio/cubit/portfolio_states.dart';
import 'package:spice_ui/service/config.dart';
import 'package:spice_ui/service/offchain_api.dart';
import 'package:spice_ui/service/spice_program.dart';
import 'package:spice_ui/utils/global_functions.dart';
import 'package:spice_ui/utils/toastification.dart';

class PortfolioCubit extends Cubit<PortfolioStates> {
  PortfolioCubit(super.initialState);

  final Connection connection =
      Connection(Cluster(Uri.parse(SolanaConfig.rpc)));

  Portfolio? portfolio;

  clearPortfolioScreen() {
    portfolio = null;
    emit(NoPortfolioScreenState());
  }

  Future<void> loadingPortfolio({required String signer}) async {
      emit(LoadingPortfolioScreenState());

      if (portfolio == null) {
        var positions = <Position>[];

        var prices = await OffchainApi.getPriceForPoolsTokens();

        var tokenAccountBySigner = await connection.getTokenAccountsByOwner(
            Pubkey.fromBase58(signer),
            filter: TokenAccountsFilter.programId(TokenProgram.programId));

        for (var tokenAccount in tokenAccountBySigner) {
          var tokenInfo =
              TokenAccountInfo.fromAccountInfo(tokenAccount.account);

          for (var pool in poolsData) {
            final poolPda = Pubkey.findProgramAddress(
                ["POOL".codeUnits, base58.decode(pool.mint)],
                SpiceProgram.programId);

            final mintPda = Pubkey.findProgramAddress(
                ["MINT".codeUnits, base58.decode(poolPda.pubkey.toBase58())],
                SpiceProgram.programId);

            if (mintPda.pubkey.toBase58() == tokenInfo.mint) {
              var getPoolAccountInfo = await connection.getAccountInfo(
                  poolPda.pubkey,
                  config: GetAccountInfoConfig(encoding: AccountEncoding.base64));
              var poolAccountInfo = PoolPda.fromAccountData(
                  base64.decode(getPoolAccountInfo?.data[0]));

              var provider = Pubkey.findProgramAddress([
                "PROVIDER".codeUnits,
                base58.decode(poolPda.pubkey.toBase58()),
                base58.decode(signer),
              ], SpiceProgram.programId);

              var getProviderAccountInfo = await connection.getAccountInfo(
                  provider.pubkey,
                  config: GetAccountInfoConfig(encoding: AccountEncoding.base64));
              var providerAccountInfo = ProviderPda.fromAccountData(
                  base64.decode(getProviderAccountInfo?.data[0]));

              final String liquidity = truncateToDecimals(
                  providerAccountInfo.lpBalance / pow(10, pool.decimals),
                  pool.decimals);
              
              final String earned = calculatingEarn(
                amount: tokenInfo.amount.toInt(), 
                poolCumulativeYield: poolAccountInfo.cumulativeYield, 
                userLastCumulativeYield: providerAccountInfo.userLastCumulativeYield, 
                initialLiquidity: poolAccountInfo.initialLiquidity,
                pendingYield: providerAccountInfo.pendingYield, 
                decimals: pool.decimals);

              num price = 0;

              try {
                var mint = pool.mint == "Gh9ZwEmdLJ8DscKNTkTqPbNwLNNBjuSzaG9Vp2KGtKJr" ? "EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v" : pool.mint;
                price = num.parse(prices[mint]['price']);
              } catch (_) {}

              final String liquidityInUsd = ((providerAccountInfo.lpBalance / pow(10, pool.decimals)) * price).toStringAsFixed(2);
              final String earnedInUsd = earned != '0' ? (num.parse(earned) * price).toStringAsFixed(2) : '0';

              positions.add(Position(
                  pool: pool,
                  liquidity: liquidity,
                  liquidityInUsd: liquidityInUsd,
                  earned: earned,
                  earnedInUsd: earnedInUsd));
            }
          }
        }

        num totalLiquidityInUsd = 0;
        num earnedInUsd = 0;
        num futureAirdrop = 0;

        for (var position in positions) {
          totalLiquidityInUsd += num.parse(position.liquidityInUsd);
          earnedInUsd += num.parse(position.earnedInUsd);
          futureAirdrop += calculatingAirdrop(position: position);
        }

        portfolio = Portfolio(
            totalLiquidityInUsd: totalLiquidityInUsd.toStringAsFixed(2),
            earnedInUsd: earnedInUsd.toStringAsFixed(2),
            futureAirdrop: futureAirdrop.toStringAsFixed(0),
            positions: positions);

      if (state is LoadingPortfolioScreenState) {
        return emit(LoadedPortfolioScreenState(portfolio: portfolio));
      }
    } else {
      emit(LoadedPortfolioScreenState(portfolio: portfolio));
    }
  }

  Future<void> updatePortfolio({required String signer}) async {
    portfolio = null;
    await loadingPortfolio(signer: signer);
  }


  Future<void> increaseLiquidity(
      {required AdapterCubit adapter,
      required Pool pool,
      required String amount, required bool isDark}) async {
    
    Toastification.processing("Approving in wallet");
    var hash = await compute((_) => connection.getLatestBlockhash(), null);

    var transaction = await SpiceProgram.increaseLiquidity(
        signer: adapter.signer!,
        pool: pool,
        amount: int.parse((num.parse(amount) * pow(10, pool.decimals)).toStringAsFixed(0)),
        blockhash: hash.blockhash);

    try {
      var signature = await adapter.signAndSendTransaction(transaction);

      Toastification.processing("Processing");

      await connection.signatureSubscribe(signature,
          config: const CommitmentConfig(commitment: Commitment.confirmed),
          onDone: () {
        Toastification.success(signature);
      }, onError: (error, [stackTrace]) {
        Toastification.error("Error");
      });
    } catch (e) {
      print(e.toString());
      Toastification.error("Rejected");
    }
  }


  Future<void> decreaseLiquidity(
      {required AdapterCubit adapter,
      required Pool pool,
      required String amount,
      required bool isDark}) async {
    Toastification.processing("Approving in wallet");
    var hash = await compute((_) => connection.getLatestBlockhash(), null);

    var transaction = await SpiceProgram.decreaseLiquidity(
        signer: adapter.signer!,
        pool: pool,
        amount: int.parse(
            (num.parse(amount) * pow(10, pool.decimals)).toStringAsFixed(0)),
        blockhash: hash.blockhash);

    try {
      var signature = await adapter.signAndSendTransaction(transaction);

      Toastification.processing("Processing");

      await connection.signatureSubscribe(signature,
          config: const CommitmentConfig(commitment: Commitment.confirmed),
          onDone: () {
        Toastification.success(signature);
      }, onError: (error, [stackTrace]) {
        Toastification.error("Error");
      });
    } catch (e) {
      Toastification.error("Rejected");
    }
  }


  Future<void> claimIncome(
      {required AdapterCubit adapter, required Pool pool, required bool isDark}) async {
    Toastification.processing("Approving in wallet");
    var hash = await compute((_) => connection.getLatestBlockhash(), null);

    var transaction = await SpiceProgram.harvestYield(
        signer: adapter.signer!, pool: pool, blockhash: hash.blockhash);

    try {
      var signature = await adapter.signAndSendTransaction(transaction);
      Toastification.processing("Processing");

      await connection.signatureSubscribe(signature,
          config: const CommitmentConfig(commitment: Commitment.confirmed),
          onDone: () {
        Toastification.success(signature);
      }, onError: (error, [stackTrace]) {
        Toastification.error("Error");
      });
    } catch (e) {
      Toastification.error("Rejected");
    }
  }
}
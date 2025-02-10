import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_web3/programs.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/pool_pda.dart';
import 'package:spice_ui/models/portfolio.dart';
import 'package:spice_ui/models/provider_pda.dart';
import 'package:spice_ui/portfolio/cubit/portfolio_states.dart';
import 'package:spice_ui/service/config.dart';
import 'package:spice_ui/service/spice_program.dart';
import 'package:spice_ui/utils/constants.dart';
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
                  config:
                      GetAccountInfoConfig(encoding: AccountEncoding.base64));
              var poolAccountInfo = PoolPda.fromAccountData(
                  base64.decode(getPoolAccountInfo?.data[0]));

              var provider = Pubkey.findProgramAddress([
                "PROVIDER".codeUnits,
                base58.decode(poolPda.pubkey.toBase58()),
                base58.decode(signer),
              ], SpiceProgram.programId);

              var getProviderAccountInfo = await connection.getAccountInfo(
                  provider.pubkey,
                  config:
                      GetAccountInfoConfig(encoding: AccountEncoding.base64));
              var providerAccountInfo = ProviderPda.fromAccountData(
                  base64.decode(getProviderAccountInfo?.data[0]));

              var liquidity = truncateToDecimals(
                  providerAccountInfo.lpBalance / pow(10, pool.decimals),
                  pool.decimals);
              
              var cumYieldPerToken = (poolAccountInfo.cumulativeYieldPerToken - providerAccountInfo.userLastCumulativeIncome) / cumulativeYieldPerTokenScale;
              var earned = truncateToDecimals((tokenInfo.amount.toInt() * cumYieldPerToken + (providerAccountInfo.pendingIncome / 1000000000)) / pow(10, pool.decimals),
                  pool.decimals);

              positions.add(Position(
                  pool: pool,
                  liquidity: liquidity,
                  liquidityInUsd: '0',
                  earned: earned,
                  earnedInUsd: '0'));
            }
          }
        }


        portfolio = Portfolio(
            totalLiquidityInUsd: '0',
            earnedInUsd: '0',
            allTimeClaimedInUsd: '0',
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


  Future<void> increaseLiquidity(BuildContext context,
      {required AdapterCubit adapter,
      required Pool pool,
      required String amount}) async {
    var hash = await connection.getLatestBlockhash();

    var transaction = await SpiceProgram.increaseLiquidity(
        signer: adapter.signer!,
        pool: pool,
        amount: int.parse(
            (num.parse(amount) * pow(10, pool.decimals)).toStringAsFixed(0)),
        blockhash: hash.blockhash);

    var signedTransaction = await adapter.signTransaction(transaction);

    var send = await connection.sendTransaction(signedTransaction);

    context.mounted ? Toastification.processing(context, "Processing") : null;

    await connection.signatureSubscribe(send,
        config: const CommitmentConfig(commitment: Commitment.confirmed),
        onDone: () {
      Toastification.success(context, send);
    }, onError: (error, [stackTrace]) {
      Toastification.soon(context, "Error");
    });
  }


  Future<void> decreaseLiquidity(BuildContext context,
      {required AdapterCubit adapter,
      required Pool pool,
      required String amount}) async {
    var hash = await connection.getLatestBlockhash();

    var transaction = await SpiceProgram.decreaseLiquidity(
        signer: adapter.signer!,
        pool: pool,
        amount: int.parse(
            (num.parse(amount) * pow(10, pool.decimals)).toStringAsFixed(0)),
        blockhash: hash.blockhash);

    var signedTransaction = await adapter.signTransaction(transaction);

    var send = await connection.sendTransaction(signedTransaction);

    context.mounted ? Toastification.processing(context, "Processing") : null;

    await connection.signatureSubscribe(send,
        config: const CommitmentConfig(commitment: Commitment.confirmed),
        onDone: () {
      Toastification.success(context, send);
    }, onError: (error, [stackTrace]) {
      Toastification.soon(context, "Error");
    });
  }


  Future<void> claimIncome(BuildContext context,
      {required AdapterCubit adapter, required Pool pool}) async {
    var hash = await connection.getLatestBlockhash();

    var transaction = await SpiceProgram.claimIncome(
        signer: adapter.signer!, pool: pool, blockhash: hash.blockhash);

    var signedTransaction = await adapter.signTransaction(transaction);

    var send = await connection.sendTransaction(signedTransaction);

    context.mounted ? Toastification.processing(context, "Processing") : null;

    await connection.signatureSubscribe(send,
        config: const CommitmentConfig(commitment: Commitment.confirmed),
        onDone: () {
      Toastification.success(context, send);
    }, onError: (error, [stackTrace]) {
      Toastification.soon(context, "Error");
    });
  }
}
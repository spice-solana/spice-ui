import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_web3/programs.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/adapter/controller/adapter_states.dart';
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/main/config.dart';
import 'package:spice_ui/main/controller/main_states.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/pool_pda.dart';
import 'package:spice_ui/models/portfolio.dart';
import 'package:spice_ui/models/provider_pda.dart';
import 'package:spice_ui/models/sroute.dart';
import 'package:spice_ui/service/spice_program.dart';
import 'package:spice_ui/utils/constants.dart';
import 'package:spice_ui/utils/global_functions.dart';
import 'package:spice_ui/utils/toastification.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit({state}) : super(LiquidityScreenState());

  final Connection connection =
      Connection(Cluster(Uri.parse(SolanaConfig.rpc)));

  Pool sell = poolsData[0];
  Pool buy = poolsData[1];

  Portfolio? portfolio;

  Timer? debounce;
  int lastRequestId = 0;

  void moveToSwapScreen() =>
      emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));
  void moveToLiquidityScreen() => emit(LiquidityScreenState());

  Future<void> moveToPortfolioScreen(AdapterStates adapterState) async {
    if (adapterState is ConnectedAdapterState) {
      emit(PortfolioScreenState(showLoadingIndicator: true));

      if (portfolio == null) {
        var positions = <Position>[];

        var tokenAccountBySigner = await connection.getTokenAccountsByOwner(
            Pubkey.fromBase58(adapterState.address),
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
                base58.decode(adapterState.address),
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
              var earned = truncateToDecimals((tokenInfo.amount.toInt() * cumYieldPerToken + providerAccountInfo.pendingIncome) / pow(10, pool.decimals),
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
      }

      if (state is PortfolioScreenState) {
        return emit(PortfolioScreenState(
            showLoadingIndicator: false, portfolio: portfolio));
      }
    } else {
      emit(PortfolioScreenState(
          showLoadingIndicator: false, portfolio: portfolio));
    }
  }

  Future<void> updatePortfolio(AdapterCubit adapterCubit) async {
    portfolio = null;
    moveToPortfolioScreen(adapterCubit.state);
  }

  void moveToChooseTokenScreen(String side) =>
      emit(ChooseTokenScreenState(side: side, pools: poolsData));

  Future<void> chooseToken({required String side, required Pool pool}) async {
    if (side == SELLING) {
      if (pool == buy) {
        return tokensFlip();
      }
      sell = pool;
    } else if (side == BUYING) {
      if (pool == sell) {
        return tokensFlip();
      }
      buy = pool;
    }
    emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));
  }

  Future<void> tokensFlip() async {
    final Pool storage = sell;
    sell = buy;
    buy = storage;
    emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));
  }

  // Get route
  Future<void> getRoute({required String inputAmount, num? slippage}) async {
    if (debounce?.isActive ?? false) debounce!.cancel();

    final int currentRequestId = ++lastRequestId;

    if (inputAmount.isEmpty || num.parse(inputAmount) == 0) {
      return emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));
    }

    debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(SwapScreenState(a: sell, b: buy, isRouteLoading: true));

      var hash = await connection.getLatestBlockhash();

      var transaction = await SpiceProgram.swap(
          signer: "aZZ8CAZ1b1Ar3x4UoB6QxTeobpg5DusHYDM1NpLX8mQ",
          inputToken: sell,
          outputToken: buy,
          inputAmount: int.parse((num.parse(inputAmount) * pow(10, sell.decimals)).toStringAsFixed(0)),
          minOutputAmount: 0,
          blockhash: hash.blockhash);

      var simulateTransaction = await connection.simulateTransaction(transaction);

      if (simulateTransaction.err != null && extractErrorMessage(simulateTransaction.logs.toString()) != null) {
        var errorMessage = extractErrorMessage(simulateTransaction.logs.toString());
        return emit(SwapScreenState(
            a: sell, b: buy, isRouteLoading: false, error: errorMessage ?? simulateTransaction.err.toString()));
      }

      var outputAmount = extractValue(simulateTransaction.logs.toString(), "Output");
      var fee = extractValue(simulateTransaction.logs.toString(), "Fee");
    
      if (currentRequestId == lastRequestId && state is SwapScreenState) {
        var routeUpdateTimeInSeconds = 15;
        emit(SwapScreenState(
            a: sell,
            b: buy,
            isRouteLoading: false,
            sroute: Sroute(
                a: sell,
                b: buy,
                inputAmount: int.parse(
                    (num.parse(inputAmount) * pow(10, sell.decimals))
                        .toStringAsFixed(0)),
                minOutputAmount: int.parse(outputAmount),
                uiOutputAmount:
                    (int.parse(outputAmount) / pow(10, buy.decimals))
                        .toStringAsFixed(buy.decimals),
                slippage: 0,
                routeUpdateTime: routeUpdateTimeInSeconds)));
      }
    });
  }

  // Swap
  Future<void> swap(BuildContext context,
      {required AdapterCubit adapter, required Sroute route}) async {
    var hash = await connection.getLatestBlockhash();

    var transaction = await SpiceProgram.swap(
        signer: adapter.signer!,
        inputToken: route.a,
        outputToken: route.b,
        inputAmount: route.inputAmount,
        minOutputAmount: route.minOutputAmount,
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

  // Increase liquidity
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

  // Decrease liquidity
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

  // Claim
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

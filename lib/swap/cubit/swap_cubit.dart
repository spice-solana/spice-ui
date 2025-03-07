import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/service/config.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/sroute.dart';
import 'package:spice_ui/service/spice_program.dart';
import 'package:spice_ui/swap/cubit/swap_states.dart';
import 'package:spice_ui/utils/constants.dart';
import 'package:spice_ui/utils/global_functions.dart';
import 'package:spice_ui/utils/toastification.dart';


class SwapCubit extends Cubit<SwapStates> {
  SwapCubit(super.initialState);

  final Connection connection = Connection(Cluster(Uri.parse(SolanaConfig.rpc)));

  Pool sell = poolsData[0];
  Pool buy = poolsData[1];

  Timer? debounce;
  int lastRequestId = 0;

  void moveToSwapScreen() =>
      emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));

  void moveToChooseTokenScreen(String side) =>
      emit(ChooseTokenSwapState(side: side, pools: poolsData));

  Future<void> tokensFlip() async {
    final Pool storage = sell;
    sell = buy;
    buy = storage;
    emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));
  }

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

  Future<void> getRoute({required String inputAmount, num? slippage}) async {
    if (debounce?.isActive ?? false) debounce!.cancel();

    final int currentRequestId = ++lastRequestId;

    if (inputAmount.isEmpty || num.parse(inputAmount) == 0) {
      return emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));
    }

    debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(SwapScreenState(a: sell, b: buy, isRouteLoading: true));

      var hash = await compute((_) => connection.getLatestBlockhash(), null);

      var transaction = await SpiceProgram.swap(
          signer: "aZZ8CAZ1b1Ar3x4UoB6QxTeobpg5DusHYDM1NpLX8mQ",
          inputToken: sell,
          outputToken: buy,
          inputAmount: int.parse((num.parse(inputAmount) * pow(10, sell.decimals)).toStringAsFixed(0)),
          minOutputAmount: 0,
          blockhash: hash.blockhash, createAta: false);

      var simulateTransaction = await connection.simulateTransaction(transaction, includeAccounts: false);

      if (simulateTransaction.err != null && extractErrorMessage(simulateTransaction.logs.toString()) != null) {
        var errorMessage = extractErrorMessage(simulateTransaction.logs.toString());
        debugPrint(errorMessage);
        return emit(SwapScreenState(
            a: sell, b: buy, isRouteLoading: false, error: errorMessage ?? simulateTransaction.err.toString()));
      }

      var outputAmount = extractValue(simulateTransaction.logs.toString(), "Net output");
      //var fee = extractValue(simulateTransaction.logs.toString(), "Fee");

      if (currentRequestId == lastRequestId && state is SwapScreenState) {
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
                    (BigInt.parse(outputAmount).toInt() / pow(10, buy.decimals))
                        .toStringAsFixed(buy.decimals),
                slippage: 0)));
      }
    });
  }

    Future<void> swap(BuildContext context,
      {required AdapterCubit adapter, required Sroute route, required bool isDark}) async {
    Toastification.processing("Approving in wallet");
    var hash = await compute((_) => connection.getLatestBlockhash(config: const CommitmentAndMinContextSlotConfig(commitment: Commitment.confirmed)), null);

    var tokenBsignerATA = route.b.mint == SpiceProgram.solAddress
        ? SpiceProgram.programId
        : Pubkey.findAssociatedTokenAddress(Pubkey.fromBase58(adapter.signer!), Pubkey.fromBase58(route.b.mint)).pubkey;

    var checkAta = await connection.getAccountInfo(tokenBsignerATA);

    var transaction = await SpiceProgram.swap(
        signer: adapter.signer!,
        inputToken: route.a,
        outputToken: route.b,
        inputAmount: route.inputAmount,
        minOutputAmount: route.minOutputAmount,
        blockhash: hash.blockhash,
        createAta: checkAta != null ? false : true);

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
      Toastification.error(e.toString());
    }
  }
}
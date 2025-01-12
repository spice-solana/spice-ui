import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/main/controller/main_states.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/sroute.dart';
import 'package:spice_ui/utils/constants.dart';


class MainCubit extends Cubit<MainStates> {
  MainCubit({state}): super(LiquidityScreenState());

  Pool sell = poolsData[0];
  Pool buy = poolsData[1];

  Timer? debounce;
  int lastRequestId = 0;

  void moveToSwapScreen() => emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));
  void moveToLiquidityScreen() => emit(LiquidityScreenState());
  void moveToPortfolioScreen() => emit(PortfolioScreenState(text: 'No data'));

  void moveToChooseTokenScreen(String side) => emit(ChooseTokenScreenState(side: side, pools: poolsData));

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

  Future<void> getRoute({required String inputAmount}) async {
    if (debounce?.isActive ?? false) debounce!.cancel();

    final int currentRequestId = ++lastRequestId;

    debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(SwapScreenState(a: sell, b: buy, isRouteLoading: true));
      await Future.delayed(const Duration(seconds: 5));
      if (currentRequestId == lastRequestId && state is SwapScreenState) {
        emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false, sroute: Sroute(outputAmount: inputAmount, slippage: 0)));
      }
    });
  }


  Future<void> sendTransaction() async {}

}
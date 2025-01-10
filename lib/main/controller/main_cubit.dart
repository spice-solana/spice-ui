import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/main/controller/main_states.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit({initialState}): super(LiquidityScreenState());

  String? walletAddress;
  bool isTables = true;

  void moveToSwap() => emit(SwapScreenState());
  void moveToLiquidity() => emit(LiquidityScreenState());
  void moveToPortfolio() => emit(PortfolioScreenState());

  Future<void> sendTransaction() async {
    
  }

}
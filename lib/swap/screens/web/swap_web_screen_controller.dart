import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/bars/bottom_web_bar.dart';
import 'package:spice_ui/bars/top_web_bar.dart';
import 'package:spice_ui/swap/cubit/swap_cubit.dart';
import 'package:spice_ui/swap/cubit/swap_states.dart';
import 'package:spice_ui/swap/screens/web/choose_token_web_screen.dart';
import 'package:spice_ui/swap/screens/web/swap_web_screen.dart';

class SwapWebScreenController extends StatefulWidget {
  const SwapWebScreenController(
      {super.key});

  @override
  State<SwapWebScreenController> createState() => _SwapWebScreenControllerState();
}

class _SwapWebScreenControllerState extends State<SwapWebScreenController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopWebBar(state: 1),
          BlocBuilder<SwapCubit, SwapStates>(builder: (context, state) {
            if (state is SwapScreenState) {
              return SwapWebScreen(a: state.a, b: state.b, isRouteLoading: state.isRouteLoading, spiceRoute: state.sroute, error: state.error);
            }
      
            if (state is ChooseTokenSwapState) {
              return ChooseTokenWebScreen(pools: state.pools, side: state.side);
            }
      
            return const SizedBox();
          }),
          const BottomWebBar()
        ],
      ),
    );
  }
}

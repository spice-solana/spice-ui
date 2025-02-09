import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/bars/bottom_bar.dart';
import 'package:spice_ui/bars/top_bar.dart';
import 'package:spice_ui/swap/cubit/swap_cubit.dart';
import 'package:spice_ui/swap/cubit/swap_states.dart';
import 'package:spice_ui/swap/screens/choose_token_screen.dart';
import 'package:spice_ui/swap/screens/swap_screen.dart';

class SwapScreenController extends StatefulWidget {
  const SwapScreenController(
      {super.key});

  @override
  State<SwapScreenController> createState() => _SwapScreenControllerState();
}

class _SwapScreenControllerState extends State<SwapScreenController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopBar(state: 1),
          BlocBuilder<SwapCubit, SwapStates>(builder: (context, state) {
            if (state is SwapScreenState) {
              return SwapScreen(a: state.a, b: state.b, isRouteLoading: state.isRouteLoading, spiceRoute: state.sroute, error: state.error);
            }
      
            if (state is ChooseCoinSwapState) {
              return ChooseCoinScreen(pools: state.pools, side: state.side);
            }
      
            return const SizedBox();
          }),
          const BottomBar()
        ],
      ),
    );
  }
}

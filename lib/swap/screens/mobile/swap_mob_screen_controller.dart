import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/bars/bottom_mob_bar.dart';
import 'package:spice_ui/bars/top_mob_bar.dart';
import 'package:spice_ui/swap/cubit/swap_cubit.dart';
import 'package:spice_ui/swap/cubit/swap_states.dart';
import 'package:spice_ui/swap/screens/mobile/choose_token_mob_screen.dart';
import 'package:spice_ui/swap/screens/mobile/swap_mob_screen.dart';

class SwapMobScreenController extends StatefulWidget {
  const SwapMobScreenController(
      {super.key});

  @override
  State<SwapMobScreenController> createState() => _SwapMobScreenControllerState();
}

class _SwapMobScreenControllerState extends State<SwapMobScreenController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopMobBar(),
          BlocBuilder<SwapCubit, SwapStates>(builder: (context, state) {
            if (state is SwapScreenState) {
              return SwapMobScreen(a: state.a, b: state.b, isRouteLoading: state.isRouteLoading, spiceRoute: state.sroute, error: state.error);
            }
      
            if (state is ChooseTokenSwapState) {
              return ChooseTokenMobScreen(pools: state.pools, side: state.side);
            }
      
            return const SizedBox();
          }),
          const BottomMobBar(active: 1)
        ],
      ),
    );
  }
}

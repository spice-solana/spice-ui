import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/interface/screens/swap/choose_token_screen.dart';
import 'package:spice_ui/main/controller/main_cubit.dart';
import 'package:spice_ui/main/controller/main_states.dart';
import 'package:spice_ui/interface/bars/bottom_bar.dart';
import 'package:spice_ui/interface/screens/liquidity/liquidity_screen.dart';
import 'package:spice_ui/interface/screens/portfolio/portfolio_screen.dart';
import 'package:spice_ui/interface/screens/swap/swap_screen.dart';
import 'package:spice_ui/interface/bars/top_bar.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isTables = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TopBar(),
        BlocBuilder<MainCubit, MainStates>(
          builder: (context, state) {
            if (state is SwapScreenState) {
              return SwapScreen(a: state.a, b: state.b, isRouteLoading: state.isRouteLoading, spiceRoute: state.sroute, error: state.error);
            }

            if (state is ChooseTokenScreenState) {
              return ChooseTokenScreen(side: state.side, pools: state.pools);
            }
        
            if (state is LiquidityScreenState) {
              return const LiquidityScreen();
            }
        
            if (state is PortfolioScreenState) {
              return PortfolioScreen(showLoadingIndicator: state.showLoadingIndicator, portfolio: state.portfolio);
            }
        
            return const SizedBox();
          },
        ),
        const BottomBar()
      ],
    ));
  }
}

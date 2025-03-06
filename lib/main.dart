import 'dart:io';
import 'package:adaptive_screen_flutter/adaptive_screen_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:oktoast/oktoast.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/liquidity/cubit/liquidity_cubit.dart';
import 'package:spice_ui/liquidity/cubit/liquidity_states.dart';
import 'package:spice_ui/liquidity/screens/mobile/liquidity_mob_screen.dart';
import 'package:spice_ui/liquidity/screens/web/liquidity_web_screen.dart';
import 'package:spice_ui/portfolio/cubit/portfolio_cubit.dart';
import 'package:spice_ui/portfolio/cubit/portfolio_states.dart';
import 'package:spice_ui/portfolio/screens/portfolio_mob_screen.dart';
import 'package:spice_ui/portfolio/screens/portfolio_web_screen.dart';
import 'package:spice_ui/swap/cubit/swap_cubit.dart';
import 'package:spice_ui/swap/cubit/swap_states.dart';
import 'package:spice_ui/swap/screens/mobile/swap_mob_screen_controller.dart';
import 'package:spice_ui/swap/screens/web/swap_web_screen_controller.dart';
import 'package:spice_ui/theme/controller/theme_cubit.dart';
import 'package:spice_ui/theme/controller/theme_states.dart';
import 'package:spice_ui/theme/themes.dart';
import 'package:spice_ui/transaction_bundle/controller/tb_cubit.dart';
import 'package:spice_ui/widgets/no_thumb_scroll_behavior.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AdaptiveScreen(
          mobile: LiquidityMobScreen(),
          web: LiquidityWebScreen(),
        ) ,
      ),
    ),
    GoRoute(
      path: '/swap',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AdaptiveScreen(
          mobile: SwapMobScreenController(),
          web: SwapWebScreenController(),
        ),
      ),
    ),
    GoRoute(
      path: '/portfolio',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AdaptiveScreen(
          mobile: PortfolioMobScreen(),
          web: PortfolioWebScreen(),
        ),
      ),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('404', style: TextStyle(fontSize: 42.0, color: Theme.of(context).hintColor)),
    ),
  )
);

void main() async {
  usePathUrlStrategy();

  var path = kIsWeb ? "" : Directory.systemTemp.path;
  Hive.init(path);

  await Hive.openBox('appBox');
  
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<PortfolioCubit>(create: (context) => PortfolioCubit(NoPortfolioScreenState())),
      BlocProvider<AdapterCubit>(
          create: (context) => AdapterCubit(context.read<PortfolioCubit>())),
      BlocProvider<SwapCubit>(create: (context) => SwapCubit(SwapScreenState(a: poolsData[0], b: poolsData[1], isRouteLoading: false))),
      BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      BlocProvider<TbCubit>(create: (_) => TbCubit()),
      BlocProvider<LiquidityCubit>(create: (_) => LiquidityCubit(HomeLiquidityScreenState(pools: poolsData)))
    ],
    child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      return OKToast(
        child: MaterialApp.router(
          title: 'Spice',
          scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
          debugShowCheckedModeBanner: false,
          theme: state.darkTheme
              ? apptheme[AppTheme.dark]
              : apptheme[AppTheme.ligth],
          routerConfig: _router,
        ),
      );
    }),
  ));
}

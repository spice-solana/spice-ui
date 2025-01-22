import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/portfolio.dart';
import 'package:spice_ui/models/sroute.dart';

abstract class MainStates {}

class SwapScreenState extends MainStates {
  final Pool a;
  final Pool b;
  final bool isRouteLoading;
  Sroute? sroute;
  String? error;

  SwapScreenState({required this.a, required this.b, required this.isRouteLoading, this.sroute, this.error});
}

class ChooseTokenScreenState extends MainStates {
  final String side;
  final List<Pool> pools;
  ChooseTokenScreenState({required this.side, required this.pools});
}

class LiquidityScreenState extends MainStates {}

class PortfolioScreenState extends MainStates {
  final bool showLoadingIndicator;
  final Portfolio? portfolio;
  PortfolioScreenState({required this.showLoadingIndicator, this.portfolio});
}
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/sroute.dart';

abstract class MainStates {}

class SwapScreenState extends MainStates {
  final Pool a;
  final Pool b;
  final bool isRouteLoading;
  Sroute? sroute;

  SwapScreenState({required this.a, required this.b, required this.isRouteLoading, this.sroute});
}

class ChooseTokenScreenState extends MainStates {
  final String side;
  final List<Pool> pools;
  ChooseTokenScreenState({required this.side, required this.pools});
}

class LiquidityScreenState extends MainStates {}

class PortfolioScreenState extends MainStates {
  final String text;
  PortfolioScreenState({required this.text});
}
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/sroute.dart';

abstract class SwapStates {}

class SwapScreenState extends SwapStates {
  final Pool a;
  final Pool b;
  final bool isRouteLoading;
  Sroute? sroute;
  String? error;

  SwapScreenState({required this.a, required this.b, required this.isRouteLoading, this.sroute, this.error});
}

class ChooseCoinSwapState extends SwapStates {
  final String side;
  final List<Pool> pools;

  ChooseCoinSwapState({required this.side, required this.pools});
}
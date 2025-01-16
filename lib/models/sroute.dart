import 'package:spice_ui/models/pool.dart';

class Sroute {
  final Pool a;
  final Pool b;
  final int inputAmount;
  final int minOutputAmount;
  final String uiOutputAmount;
  final int slippage;
  final int routeUpdateTime;

  Sroute({required this.a, required this.b, required this.inputAmount, required this.minOutputAmount, required this.uiOutputAmount, required this.slippage, required this.routeUpdateTime});
}
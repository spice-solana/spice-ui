import 'package:spice_ui/models/pool.dart';

class Portfolio {
  String totalLiquidityInUsd;
  String earnedInUsd;
  String futureAirdrop;
  final List<Position> positions;

  Portfolio({required this.totalLiquidityInUsd, required this.earnedInUsd, required this.futureAirdrop, required this.positions});
}

class Position {
  final Pool pool;
  final String liquidity;
  String liquidityInUsd;
  final String earned;
  String earnedInUsd;

  Position({required this.pool, required this.liquidity, required this.liquidityInUsd, required this.earned, required this.earnedInUsd});
}
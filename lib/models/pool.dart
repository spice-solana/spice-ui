class Pool {
  final String symbol;
  final String logoUrl;
  final String mint;
  final String pythOracle;
  final int decimals;
  String? liquidity;
  String? volume;
  String? fees;
  String? apy;

  Pool({required this.symbol, required this.logoUrl, required this.mint, required this.pythOracle, required this.decimals, this.liquidity, this.volume, this.fees, this.apy}) {
    liquidity ??= "0";
    volume ??= "0";
    fees ??= "0";
    apy ??= "0";
  }
}
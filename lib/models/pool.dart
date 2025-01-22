class Pool {
  final String symbol;
  final String logoUrl;
  final String mint;
  final String pythOracle;
  final int decimals;
  String? signerBalance;

  Pool({required this.symbol, required this.logoUrl, required this.mint, required this.pythOracle, required this.decimals, this.signerBalance});
}
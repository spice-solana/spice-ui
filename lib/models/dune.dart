class Dune {
  final num balanceUsd;
  final num feeUsd;
  final String symbol;
  final num volumeUsd;

  Dune({required this.balanceUsd, required this.feeUsd, required this.symbol, required this.volumeUsd});

  factory Dune.fromJson(json) {
    return Dune(
      balanceUsd: json['balance_usd'], 
      feeUsd: json['fee_usd'], 
      symbol: json['symbol'], 
      volumeUsd: json['volume_usd']
    );
  }
}
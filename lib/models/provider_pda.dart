import 'package:fixnum/fixnum.dart';

class ProviderPda {
  final int lpBalance;
  final int cumulativeYieldClaimed;

  ProviderPda({required this.lpBalance, required this.cumulativeYieldClaimed});

  factory ProviderPda.fromAccountData(List<int> data) {
    return ProviderPda( 
      lpBalance: Int64.fromBytes(data.getRange(8, 16).toList()).toInt(),
      cumulativeYieldClaimed: Int64.fromBytes(data.getRange(16, 24).toList()).toInt(),
    );
  }
}
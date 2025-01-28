import 'package:fixnum/fixnum.dart';

class ProviderPda {
  final int lpBalance;
  final int cumulativeYieldClaimed;
  final int userLastCumulativeIncome;
  final int pendingIncome;

  ProviderPda({required this.lpBalance, required this.cumulativeYieldClaimed, required this.userLastCumulativeIncome, required this.pendingIncome});

  factory ProviderPda.fromAccountData(List<int> data) {
    return ProviderPda( 
      lpBalance: Int64.fromBytes(data.getRange(8, 16).toList()).toInt(),
      cumulativeYieldClaimed: Int64.fromBytes(data.getRange(16, 24).toList()).toInt(),
      userLastCumulativeIncome: Int64.fromBytes(data.getRange(24, 32).toList()).toInt(),
      pendingIncome: Int64.fromBytes(data.getRange(32, 40).toList()).toInt()
    );
  }
}
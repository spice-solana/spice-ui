import 'package:fixnum/fixnum.dart';

class ProviderPda {
  final int lpBalance;
  final int userLastCumulativeYield;
  final int pendingYield;

  ProviderPda({required this.lpBalance, required this.userLastCumulativeYield, required this.pendingYield});

  factory ProviderPda.fromAccountData(List<int> data) {
    return ProviderPda( 
      lpBalance: Int64.fromBytes(data.getRange(8, 16).toList()).toInt(),
      userLastCumulativeYield: Int64.fromBytes(data.getRange(16, 24).toList()).toInt(),
      pendingYield: Int64.fromBytes(data.getRange(24, 32).toList()).toInt()
    );
  }
}
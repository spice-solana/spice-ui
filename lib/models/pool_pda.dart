import 'dart:typed_data';
import 'package:solana_web3/solana_web3.dart';
import 'package:fixnum/fixnum.dart';


class PoolPda {
  final bool isActive;
  final int baseFee;
  final String mint;
  final String pythPriceFeedAccount;
  final String lpTokenMint;
  final int initialLiquidity;
  final int cumulativeYield;
  final int currentLiquidity;
  final int protocolIncome;

  PoolPda({required this.isActive, required this.baseFee, required this.mint, required this.pythPriceFeedAccount, required this.lpTokenMint, required this.initialLiquidity, required this.cumulativeYield, required this.currentLiquidity, required this.protocolIncome});

  factory PoolPda.fromAccountData(List<int> data) {
    return PoolPda( 
      isActive: data.getRange(8, 9).toList()[0] == 1 ? true : false,
      baseFee: Int64.fromBytes(data.getRange(9, 17).toList()).toInt(),
      mint: base58.encode(Uint8List.fromList(data.getRange(17, 49).toList())), 
      pythPriceFeedAccount: base58.encode(Uint8List.fromList(data.getRange(49, 81).toList())), 
      lpTokenMint: base58.encode(Uint8List.fromList(data.getRange(81, 113).toList())), 
      initialLiquidity: Int64.fromBytes(data.getRange(113, 121).toList()).toInt(), 
      cumulativeYield: Int64.fromBytes(data.getRange(121, 129).toList()).toInt(),
      currentLiquidity: Int64.fromBytes(data.getRange(129, 137).toList()).toInt(),
      protocolIncome: Int64.fromBytes(data.getRange(137, 145).toList()).toInt()
    );
  }
}
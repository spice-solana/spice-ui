import 'dart:typed_data';
import 'package:solana_web3/solana_web3.dart';
import 'package:fixnum/fixnum.dart';


class PoolPda {
  final String mint;
  final String pythPriceFeedAccount;
  final String lpTokenMint;
  final int totalLpSupply;
  final int cumulativeYieldPerToken;
  final int balance;
  final int protocolIncome;

  PoolPda({required this.mint, required this.pythPriceFeedAccount, required this.lpTokenMint, required this.totalLpSupply, required this.cumulativeYieldPerToken, required this.balance, required this.protocolIncome});

  factory PoolPda.fromAccountData(List<int> data) {
    return PoolPda( 
      mint: base58.encode(Uint8List.fromList(data.getRange(8, 40).toList())), 
      pythPriceFeedAccount: base58.encode(Uint8List.fromList(data.getRange(40, 72).toList())), 
      lpTokenMint: base58.encode(Uint8List.fromList(data.getRange(72, 104).toList())), 
      totalLpSupply: Int64.fromBytes(data.getRange(104, 112).toList()).toInt(), 
      cumulativeYieldPerToken: Int64.fromBytes(data.getRange(112, 120).toList()).toInt(),
      balance: Int64.fromBytes(data.getRange(120, 128).toList()).toInt(),
      protocolIncome: Int64.fromBytes(data.getRange(128, 136).toList()).toInt()
    );
  }
}
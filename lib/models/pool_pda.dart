import 'dart:typed_data';
import 'package:solana_web3/solana_web3.dart';
import 'package:fixnum/fixnum.dart';

  // int bytesToInt64(List<int> data) {
  //   if (data.length != 8) {
  //     throw ArgumentError("Data must contain exactly 8 bytes.");
  //   }

  //   int high = Uint8List.fromList(data.getRange(0, 4).toList()).buffer.asByteData().getInt32(0, Endian.host);
  //   int low = Uint8List.fromList(data.getRange(0, 8).toList()).buffer.asByteData().getInt32(0, Endian.host);

  //   return (high << 32) | low;
  // }

class PoolPda {
  final String mint;
  final int decimals;
  final String pythPriceFeedAccount;
  final String lpTokenMint;
  final int totalLpSupply;
  final int cumulativeYieldPerToken;
  final int balance;
  final int protocolIncome;

  PoolPda({required this.mint, required this.decimals, required this.pythPriceFeedAccount, required this.lpTokenMint, required this.totalLpSupply, required this.cumulativeYieldPerToken, required this.balance, required this.protocolIncome});

  factory PoolPda.fromAccountData(List<int> data) {
    return PoolPda( 
      mint: base58.encode(Uint8List.fromList(data.getRange(8, 40).toList())), 
      decimals: Uint8List.fromList(data.getRange(40, 41).toList()).buffer.asByteData().getUint8(0),
      pythPriceFeedAccount: base58.encode(Uint8List.fromList(data.getRange(41, 73).toList())), 
      lpTokenMint: base58.encode(Uint8List.fromList(data.getRange(73, 105).toList())), 
      totalLpSupply: Int64.fromBytes(data.getRange(105, 113).toList()).toInt(), 
      cumulativeYieldPerToken: Int64.fromBytes(data.getRange(113, 121).toList()).toInt(),
      balance: Int64.fromBytes(data.getRange(121, 129).toList()).toInt(),
      protocolIncome: Int64.fromBytes(data.getRange(129, 137).toList()).toInt()
    );
  }
}
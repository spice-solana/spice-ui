import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:solana_web3/programs.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/models/pool.dart';

class SpiceProgram {

  static String solAddress = "So11111111111111111111111111111111111111112";
  static Pubkey programId = Pubkey.fromBase58("pkiDHUHtob4vezAQhERS14pskTdxbv9S1hqW6YKVLoX");

  static Future getRoute({required Pool inputToken, required Pool outputToken, required int inputAmount}) async {
    
  }

  static Future<Transaction> swap({required String signer, required Pool inputToken, required Pool outputToken, required int inputAmount, required int minOutputAmount, required String blockhash}) async {
    final List<int> data = [];
    data.addAll(sha256.convert('global:swap'.codeUnits).bytes.getRange(0, 8).toList());
    data.addAll(Uint8List(8)..buffer.asByteData().setInt32(0, inputAmount, Endian.host));
    data.addAll(Uint8List(8)..buffer.asByteData().setInt32(0, minOutputAmount, Endian.host));

    final tokenAPoolPDA = Pubkey.findProgramAddress([
      "POOL".codeUnits,
      base58.decode(inputToken.mint)
    ], programId);

    final tokenBPoolPDA = Pubkey.findProgramAddress([
      "POOL".codeUnits,
      base58.decode(outputToken.mint)
    ], programId);

    var tokenAsignerATA = inputToken.mint == solAddress ? programId : Pubkey.findProgramAddress([
      base58.decode(signer),
      base58.decode(TokenProgram.programId.toBase58()),
      base58.decode(inputToken.mint),
    ], AssociatedTokenProgram.programId).pubkey;

    var tokenBsignerATA = outputToken.mint == solAddress ? programId : Pubkey.findProgramAddress([
      base58.decode(signer),
      base58.decode(TokenProgram.programId.toBase58()),
      base58.decode(outputToken.mint),
    ], AssociatedTokenProgram.programId).pubkey;

    var treasury = Pubkey.findProgramAddress([
      "SPICE".codeUnits,
      "TREASURY".codeUnits,
    ], programId);

    var tokenAtreasuryATA = inputToken.mint == solAddress ? programId : Pubkey.findProgramAddress([
      base58.decode(treasury.pubkey.toBase58()),
      base58.decode(TokenProgram.programId.toBase58()),
      base58.decode(inputToken.mint),
    ], AssociatedTokenProgram.programId).pubkey;

    var tokenBtreasuryATA = outputToken.mint == solAddress ? programId : Pubkey.findProgramAddress([
      base58.decode(treasury.pubkey.toBase58()),
      base58.decode(TokenProgram.programId.toBase58()),
      base58.decode(outputToken.mint),
    ], AssociatedTokenProgram.programId).pubkey;

    var transaction = Transaction(message: Message.v0(
      payer: Pubkey.fromBase58(signer), 
      instructions: [
        TransactionInstruction(
          keys: [
            AccountMeta.signerAndWritable(Pubkey.fromBase58(signer)),
            AccountMeta.writable(Pubkey.fromBase58(inputToken.mint)),
            AccountMeta.writable(Pubkey.fromBase58(outputToken.mint)),
            AccountMeta.writable(Pubkey.fromBase58(inputToken.pythOracle)),
            AccountMeta.writable(Pubkey.fromBase58(outputToken.pythOracle)),
            AccountMeta.writable(tokenAPoolPDA.pubkey),
            AccountMeta.writable(tokenBPoolPDA.pubkey),
            AccountMeta.writable(tokenAsignerATA),
            AccountMeta.writable(tokenBsignerATA),
            AccountMeta.writable(treasury.pubkey),
            AccountMeta.writable(tokenAtreasuryATA),
            AccountMeta.writable(tokenBtreasuryATA),
            AccountMeta(TokenProgram.programId, isSigner: false, isWritable: false),
            AccountMeta(SystemProgram.programId, isSigner: false, isWritable: false),
          ], 
          programId: programId, 
          data: Uint8List.fromList(data))
      ], 
      recentBlockhash: blockhash
    ));

    return transaction;
  }

}
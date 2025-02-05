import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:fixnum/fixnum.dart';
import 'package:solana_web3/programs.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/models/pool.dart';

class SpiceProgram {
  static String solAddress = "So11111111111111111111111111111111111111112";
  static Pubkey programId = Pubkey.fromBase58("DWs9rHogNhKwUtheext7iQVKA8BED4Fb5atzcyDsJKVx");


  static Future<Transaction> increaseLiquidity(
      {required String signer,
      required Pool pool,
      required int amount,
      required String blockhash}) async {
    final List<int> data = [];
    data.addAll(sha256.convert('global:increase_liquidity'.codeUnits).bytes.getRange(0, 8).toList());
    data.addAll(Int64(amount).toBytes());
    
    final poolPDA = Pubkey.findProgramAddress(
        ["POOL".codeUnits, base58.decode(pool.mint)], programId);

    var lpTokenMint = Pubkey.findProgramAddress(
        ["MINT".codeUnits, base58.decode(poolPDA.pubkey.toBase58())],
        SpiceProgram.programId);

    var provider = Pubkey.findProgramAddress([
      "PROVIDER".codeUnits,
      base58.decode(poolPDA.pubkey.toBase58()),
      base58.decode(signer),
    ], SpiceProgram.programId);

    var signerLpATA = Pubkey.findProgramAddress([
            base58.decode(signer),
            base58.decode(TokenProgram.programId.toBase58()),
            base58.decode(lpTokenMint.pubkey.toBase58()),
          ], AssociatedTokenProgram.programId)
            .pubkey;

    var signerATA = pool.mint == solAddress
        ? SpiceProgram.programId
        : Pubkey.findProgramAddress([
            base58.decode(signer),
            base58.decode(TokenProgram.programId.toBase58()),
            base58.decode(pool.mint),
          ], AssociatedTokenProgram.programId)
            .pubkey;

    var treasury = Pubkey.findProgramAddress([
      "SPICE".codeUnits,
      "TREASURY".codeUnits,
    ], SpiceProgram.programId);

    var treasuryATA = pool.mint == solAddress
        ? SpiceProgram.programId
        : Pubkey.findProgramAddress([
            base58.decode(treasury.pubkey.toBase58()),
            base58.decode(TokenProgram.programId.toBase58()),
            base58.decode(pool.mint),
          ], AssociatedTokenProgram.programId)
            .pubkey;

    var transaction = Transaction(
        message: Message.v0(
            payer: Pubkey.fromBase58(signer),
            instructions: [
              TransactionInstruction(
                  keys: [
                    AccountMeta.signerAndWritable(Pubkey.fromBase58(signer)),
                    AccountMeta.writable(Pubkey.fromBase58(pool.mint)),
                    AccountMeta.writable(signerATA),
                    AccountMeta.writable(signerLpATA),
                    AccountMeta.writable(poolPDA.pubkey),
                    AccountMeta.writable(lpTokenMint.pubkey),
                    AccountMeta.writable(provider.pubkey),
                    AccountMeta.writable(treasury.pubkey),
                    AccountMeta.writable(treasuryATA),
                    AccountMeta(AssociatedTokenProgram.programId,
                        isSigner: false, isWritable: false),
                    AccountMeta(TokenProgram.programId,
                        isSigner: false, isWritable: false),
                    AccountMeta(SystemProgram.programId,
                        isSigner: false, isWritable: false),
                  ],
                  programId: SpiceProgram.programId,
                  data: Uint8List.fromList(data))
            ],
            recentBlockhash: blockhash));
 
        return transaction;
  }

    static Future<Transaction> decreaseLiquidity(
      {required String signer,
      required Pool pool,
      required int amount,
      required String blockhash}) async {
    final List<int> data = [];
    data.addAll(sha256.convert('global:decrease_liquidity'.codeUnits).bytes.getRange(0, 8).toList());
    data.addAll(Int64(amount).toBytes());
    
    final poolPDA = Pubkey.findProgramAddress(
        ["POOL".codeUnits, base58.decode(pool.mint)], programId);

    var lpTokenMint = Pubkey.findProgramAddress(
        ["MINT".codeUnits, base58.decode(poolPDA.pubkey.toBase58())],
        SpiceProgram.programId);

    var provider = Pubkey.findProgramAddress([
      "PROVIDER".codeUnits,
      base58.decode(poolPDA.pubkey.toBase58()),
      base58.decode(signer),
    ], SpiceProgram.programId);

    var signerLpATA = Pubkey.findProgramAddress([
            base58.decode(signer),
            base58.decode(TokenProgram.programId.toBase58()),
            base58.decode(lpTokenMint.pubkey.toBase58()),
          ], AssociatedTokenProgram.programId)
            .pubkey;

    var signerATA = pool.mint == solAddress
        ? SpiceProgram.programId
        : Pubkey.findProgramAddress([
            base58.decode(signer),
            base58.decode(TokenProgram.programId.toBase58()),
            base58.decode(pool.mint),
          ], AssociatedTokenProgram.programId)
            .pubkey;

    var treasury = Pubkey.findProgramAddress([
      "SPICE".codeUnits,
      "TREASURY".codeUnits,
    ], SpiceProgram.programId);

    var treasuryATA = pool.mint == solAddress
        ? SpiceProgram.programId
        : Pubkey.findProgramAddress([
            base58.decode(treasury.pubkey.toBase58()),
            base58.decode(TokenProgram.programId.toBase58()),
            base58.decode(pool.mint),
          ], AssociatedTokenProgram.programId)
            .pubkey;

    var transaction = Transaction(
        message: Message.v0(
            payer: Pubkey.fromBase58(signer),
            instructions: [
              TransactionInstruction(
                  keys: [
                    AccountMeta.signerAndWritable(Pubkey.fromBase58(signer)),
                    AccountMeta.writable(Pubkey.fromBase58(pool.mint)),
                    AccountMeta.writable(signerATA),
                    AccountMeta.writable(signerLpATA),
                    AccountMeta.writable(poolPDA.pubkey),
                    AccountMeta.writable(lpTokenMint.pubkey),
                    AccountMeta.writable(provider.pubkey),
                    AccountMeta.writable(treasury.pubkey),
                    AccountMeta.writable(treasuryATA),
                    AccountMeta(AssociatedTokenProgram.programId,
                        isSigner: false, isWritable: false),
                    AccountMeta(TokenProgram.programId,
                        isSigner: false, isWritable: false),
                    AccountMeta(SystemProgram.programId,
                        isSigner: false, isWritable: false),
                  ],
                  programId: SpiceProgram.programId,
                  data: Uint8List.fromList(data))
            ],
            recentBlockhash: blockhash));
 
        return transaction;
  }


  static Future<Transaction> claimIncome({required String signer, required Pool pool, required String blockhash}) async {
    final List<int> data = [];
    data.addAll(sha256.convert('global:claim_income'.codeUnits).bytes.getRange(0, 8).toList());
    
    final poolPDA = Pubkey.findProgramAddress(
        ["POOL".codeUnits, base58.decode(pool.mint)], programId);

    var provider = Pubkey.findProgramAddress([
      "PROVIDER".codeUnits,
      base58.decode(poolPDA.pubkey.toBase58()),
      base58.decode(signer),
    ], SpiceProgram.programId);

    var signerATA = pool.mint == solAddress
        ? SpiceProgram.programId
        : Pubkey.findProgramAddress([
            base58.decode(signer),
            base58.decode(TokenProgram.programId.toBase58()),
            base58.decode(pool.mint),
          ], AssociatedTokenProgram.programId)
            .pubkey;

    var treasury = Pubkey.findProgramAddress([
      "SPICE".codeUnits,
      "TREASURY".codeUnits,
    ], SpiceProgram.programId);

    var treasuryATA = pool.mint == solAddress
        ? SpiceProgram.programId
        : Pubkey.findProgramAddress([
            base58.decode(treasury.pubkey.toBase58()),
            base58.decode(TokenProgram.programId.toBase58()),
            base58.decode(pool.mint),
          ], AssociatedTokenProgram.programId)
            .pubkey;

    var transaction = Transaction(
        message: Message.v0(
            payer: Pubkey.fromBase58(signer),
            instructions: [
              TransactionInstruction(
                  keys: [
                    AccountMeta.signerAndWritable(Pubkey.fromBase58(signer)),
                    AccountMeta.writable(Pubkey.fromBase58(pool.mint)),
                    AccountMeta.writable(signerATA),
                    AccountMeta.writable(poolPDA.pubkey),
                    AccountMeta.writable(provider.pubkey),
                    AccountMeta.writable(treasury.pubkey),
                    AccountMeta.writable(treasuryATA),
                    AccountMeta(TokenProgram.programId,
                        isSigner: false, isWritable: false),
                    AccountMeta(SystemProgram.programId,
                        isSigner: false, isWritable: false),
                  ],
                  programId: SpiceProgram.programId,
                  data: Uint8List.fromList(data))
            ],
            recentBlockhash: blockhash));
 
        return transaction;
  }


  static Future<Transaction> swap(
      {required String signer,
      required Pool inputToken,
      required Pool outputToken,
      required int inputAmount,
      required int minOutputAmount,
      required String blockhash}) async {
    final List<int> data = [];
    data.addAll(
        sha256.convert('global:swap'.codeUnits).bytes.getRange(0, 8).toList());
    data.addAll(Int64(inputAmount).toBytes());
    data.addAll(Int64(minOutputAmount).toBytes());

    final tokenAPoolPDA = Pubkey.findProgramAddress(
        ["POOL".codeUnits, base58.decode(inputToken.mint)],
        SpiceProgram.programId);

    final tokenBPoolPDA = Pubkey.findProgramAddress(
        ["POOL".codeUnits, base58.decode(outputToken.mint)],
        SpiceProgram.programId);

    var tokenAsignerATA = inputToken.mint == solAddress
        ? SpiceProgram.programId
        : Pubkey.findProgramAddress([
            base58.decode(signer),
            base58.decode(TokenProgram.programId.toBase58()),
            base58.decode(inputToken.mint),
          ], AssociatedTokenProgram.programId)
            .pubkey;

    var tokenBsignerATA = outputToken.mint == solAddress
        ? SpiceProgram.programId
        : Pubkey.findProgramAddress([
            base58.decode(signer),
            base58.decode(TokenProgram.programId.toBase58()),
            base58.decode(outputToken.mint),
          ], AssociatedTokenProgram.programId)
            .pubkey;

    var treasury = Pubkey.findProgramAddress([
      "SPICE".codeUnits,
      "TREASURY".codeUnits,
    ], SpiceProgram.programId);

    var tokenAtreasuryATA = inputToken.mint == solAddress
        ? SpiceProgram.programId
        : Pubkey.findProgramAddress([
            base58.decode(treasury.pubkey.toBase58()),
            base58.decode(TokenProgram.programId.toBase58()),
            base58.decode(inputToken.mint),
          ], AssociatedTokenProgram.programId)
            .pubkey;

    var tokenBtreasuryATA = outputToken.mint == solAddress
        ? SpiceProgram.programId
        : Pubkey.findProgramAddress([
            base58.decode(treasury.pubkey.toBase58()),
            base58.decode(TokenProgram.programId.toBase58()),
            base58.decode(outputToken.mint),
          ], AssociatedTokenProgram.programId)
            .pubkey;

    var transaction = Transaction(
        message: Message.v0(
            payer: Pubkey.fromBase58(signer),
            instructions: [
              TransactionInstruction(keys: [
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
                AccountMeta(TokenProgram.programId,
                    isSigner: false, isWritable: false),
                AccountMeta(SystemProgram.programId,
                    isSigner: false, isWritable: false),
              ], programId: programId, data: Uint8List.fromList(data))
            ],
            recentBlockhash: blockhash));

    return transaction;
  }
}

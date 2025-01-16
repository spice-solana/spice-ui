import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/main/config.dart';
import 'package:spice_ui/main/controller/main_states.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/pool_pda.dart';
import 'package:spice_ui/models/pyth.dart';
import 'package:spice_ui/models/sroute.dart';
import 'package:spice_ui/service/spice_program.dart';
import 'package:spice_ui/utils/constants.dart';
import 'package:spice_ui/utils/toastification.dart';


class MainCubit extends Cubit<MainStates> {
  final AdapterCubit adapter;
  MainCubit(this.adapter): super(LiquidityScreenState());

  final Connection connection = Connection(Cluster(Uri.parse(SolanaConfig.rpc)));

  Pool sell = poolsData[0];
  Pool buy = poolsData[1];

  Timer? debounce;
  int lastRequestId = 0;

  void moveToSwapScreen() {
    if (adapter.signer != null) {
      // load balances
    }
    emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));
  }
  void moveToLiquidityScreen() => emit(LiquidityScreenState());
  void moveToPortfolioScreen() => emit(PortfolioScreenState(text: 'No data'));

  void moveToChooseTokenScreen(String side) => emit(ChooseTokenScreenState(side: side, pools: poolsData));

  Future<void> chooseToken({required String side, required Pool pool}) async {
    if (side == SELLING) {
      if (pool == buy) {
        return tokensFlip();
      }
      sell = pool;
    } else if (side == BUYING) {
      if (pool == sell) {
        return tokensFlip();
      }
      buy = pool;
    }
    emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));
  }

  Future<void> tokensFlip() async {
    final Pool storage = sell;
    sell = buy;
    buy = storage;
    emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));
  }


  Future<void> getRoute({required String inputAmount, num? slippage}) async {
    if (debounce?.isActive ?? false) debounce!.cancel();

    final int currentRequestId = ++lastRequestId;

    if (inputAmount.isEmpty || num.parse(inputAmount) == 0) {
      return emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));
    }

    debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(SwapScreenState(a: sell, b: buy, isRouteLoading: true));

    // Get route:
    // 1. Pool A & Pool B
    final tokenAPoolPDA = Pubkey.findProgramAddress([
      "POOL".codeUnits,
      base58.decode(sell.mint)
    ], SpiceProgram.programId);

    final tokenBPoolPDA = Pubkey.findProgramAddress([
      "POOL".codeUnits,
      base58.decode(buy.mint)
    ], SpiceProgram.programId);
    
    var getAPoolAccountInfo = await connection.getAccountInfo(tokenAPoolPDA.pubkey, config: GetAccountInfoConfig(encoding: AccountEncoding.base64));
    var aPoolAccountInfo = PoolPda.fromAccountData(base64.decode(getAPoolAccountInfo?.data[0]));

    var getBPoolAccountInfo = await connection.getAccountInfo(tokenBPoolPDA.pubkey, config: GetAccountInfoConfig(encoding: AccountEncoding.base64));
    var bPoolAccountInfo = PoolPda.fromAccountData(base64.decode(getBPoolAccountInfo?.data[0]));

    // 2. Price for A and B
    var getAPythAccountInfo = await connection.getAccountInfo(Pubkey.fromBase58(aPoolAccountInfo.pythPriceFeedAccount), config: GetAccountInfoConfig(encoding: AccountEncoding.base64));
    var getBPythAccountInfo = await connection.getAccountInfo(Pubkey.fromBase58(bPoolAccountInfo.pythPriceFeedAccount), config: GetAccountInfoConfig(encoding: AccountEncoding.base64));
    
    var aPyth = Pyth.fromAccountData(base64.decode(getAPythAccountInfo?.data[0]));
    var bPyth = Pyth.fromAccountData(base64.decode(getBPythAccountInfo?.data[0]));

    var aPrice = aPyth.price + aPyth.emaConf;
    var bPrice = bPyth.price - bPyth.emaConf;

    var deltaA = aPoolAccountInfo.balance - aPoolAccountInfo.totalLpSupply;
    var deltaB = bPoolAccountInfo.balance - bPoolAccountInfo.totalLpSupply;

    var fee = 0.01;
    
    if (deltaA < 0 && deltaB > 0) {
        fee = 0.01;
    }

    var aBalance = num.parse(inputAmount) * aPrice;
    var outputAmount = aBalance / bPrice;

    var feeOutput = outputAmount * (fee / 100);

    outputAmount - feeOutput;

    if (bPoolAccountInfo.balance < outputAmount * pow(10, bPoolAccountInfo.decimals)) {
      print(bPoolAccountInfo.balance / pow(10, bPoolAccountInfo.decimals));
      return emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false, error: "Insufficient liquidity"));
    }
    

    if (currentRequestId == lastRequestId && state is SwapScreenState) {
      var routeUpdateTimeInSeconds = 15;
        emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false, 
          sroute: Sroute(
            a: sell,
            b: buy,
            inputAmount: int.parse((num.parse(inputAmount) * pow(10, aPoolAccountInfo.decimals)).toStringAsFixed(0)),
            minOutputAmount: int.parse((outputAmount * pow(10, bPoolAccountInfo.decimals)).toStringAsFixed(0)),
            uiOutputAmount: outputAmount.toStringAsFixed(bPoolAccountInfo.decimals), 
            slippage: 0,
            routeUpdateTime: routeUpdateTimeInSeconds)));
      }
    });
  }


  Future<void> swap(BuildContext context, {required Sroute route}) async {

    var hash = await connection.getLatestBlockhash();

    // Build tx
    var transaction = await SpiceProgram.swap(
      signer: adapter.signer!, 
      inputToken: route.a, 
      outputToken: route.b, 
      inputAmount: route.inputAmount, 
      minOutputAmount: route.minOutputAmount, 
      blockhash: hash.blockhash
    );

    // Sign tx
    var signedTransaction = await adapter.signTransaction(transaction);

    // Send tx
    var send = await connection.sendTransaction(signedTransaction);

    context.mounted ? Toastification.processing(context, "Processing") : null;

    await connection.signatureSubscribe(send, config: const CommitmentConfig(commitment: Commitment.confirmed), 
      onDone: () {
        Toastification.success(context, send);
    }, onError: (error, [stackTrace]) {
        Toastification.soon(context, "Error");
    });

  }

  Future<void> increaseLiquidity(BuildContext context, {required Pool pool, required String amount}) async {
    var hash = await connection.getLatestBlockhash();

    var transaction = await SpiceProgram.increaseLiquidity(
      signer: adapter.signer!, 
      pool: pool, 
      amount: int.parse((num.parse(amount) * pow(10, pool.decimals)).toStringAsFixed(0)), 
      blockhash: hash.blockhash);

    // Sign tx
    var signedTransaction = await adapter.signTransaction(transaction);

    // Send tx
    var send = await connection.sendTransaction(signedTransaction);

    context.mounted ? Toastification.processing(context, "Processing") : null;

    await connection.signatureSubscribe(send, config: const CommitmentConfig(commitment: Commitment.confirmed), 
      onDone: () {
        Toastification.success(context, send);
    }, onError: (error, [stackTrace]) {
        Toastification.soon(context, "Error");
    });
  }

}
import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/main/controller/main_states.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/pool_pda.dart';
import 'package:spice_ui/models/pyth.dart';
import 'package:spice_ui/models/sroute.dart';
import 'package:spice_ui/service/spice_program.dart';
import 'package:spice_ui/utils/constants.dart';


class MainCubit extends Cubit<MainStates> {
  MainCubit({state}): super(LiquidityScreenState());

  final Connection connection = Connection(Cluster(Uri.parse('https://devnet.helius-rpc.com/?api-key=e73529ad-6e9e-417e-91a1-564aea0a32d3')));

  Pool sell = poolsData[0];
  Pool buy = poolsData[1];

  Timer? debounce;
  int lastRequestId = 0;

  void moveToSwapScreen() => emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false));
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


  Future<void> getRoute({required String inputAmount}) async {
    if (debounce?.isActive ?? false) debounce!.cancel();

    final int currentRequestId = ++lastRequestId;

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

    var fee = 0.001;
    
    if (deltaA < 0 && deltaB > 0) {
        fee = 0;
    }

    var aBalance = num.parse(inputAmount) * aPrice;
    var output = (aBalance / bPrice) * (1 - fee);

    if (currentRequestId == lastRequestId && state is SwapScreenState) {
        emit(SwapScreenState(a: sell, b: buy, isRouteLoading: false, sroute: Sroute(outputAmount: output.toStringAsFixed(6), slippage: 0)));
      }
    });
  }


  Future<void> sendTransaction() async {}

}
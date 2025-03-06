import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/liquidity/cubit/liquidity_states.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/pool_pda.dart';
import 'package:spice_ui/service/config.dart';
import 'package:spice_ui/service/offchain_api.dart';
import 'package:spice_ui/service/spice_program.dart';
import 'package:spice_ui/utils/constants.dart';
import 'package:spice_ui/utils/extensions.dart';


class LiquidityCubit extends Cubit<HomeLiquidityScreenState> {
  LiquidityCubit(super.initialState) {
    getPoolsInfo();
  }

  final Connection connection =
      Connection(Cluster(Uri.parse(SolanaConfig.rpc)));

  Future<void> getPoolsInfo() async {
    List<Pool> list = [];
    var prices = await OffchainApi.getPriceForPoolsTokens();
    
    for (var pool in poolsData) {
      final poolPda = Pubkey.findProgramAddress(
          ["POOL".codeUnits, base58.decode(pool.mint)], SpiceProgram.programId);
      var getPoolAccountInfo = await connection.getAccountInfo(poolPda.pubkey,
          config: GetAccountInfoConfig(encoding: AccountEncoding.base64));
      var poolAccountInfo = PoolPda.fromAccountData(base64.decode(getPoolAccountInfo?.data[0]));
      list.add(
        Pool(
          symbol: pool.symbol, 
          logoUrl: pool.logoUrl, 
          mint: pool.mint, 
          pythOracle: pool.pythOracle, 
          decimals: pool.decimals,
          liquidity: ((poolAccountInfo.currentLiquidity / pow(10, pool.decimals)) * num.parse(prices[pool.mint]['price'])).toStringAsFixed(2).formatNumWithCommas(),
          volume: ((100 / (poolAccountInfo.baseFee / 1000)) * (poolAccountInfo.cumulativeYield / cumulativeYieldScaleConstant / pow(10, pool.decimals))).toStringAsFixed(2).formatNumWithCommas()
        )
      );
    }

    emit(HomeLiquidityScreenState(pools: list));
  }

}

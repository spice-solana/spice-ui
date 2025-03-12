import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/liquidity/cubit/liquidity_states.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/service/config.dart';
import 'package:spice_ui/service/offchain_api.dart';
import 'package:spice_ui/utils/extensions.dart';


class LiquidityCubit extends Cubit<HomeLiquidityScreenState> {
  LiquidityCubit(super.initialState) {
    getPoolsInfo();
  }

  final Connection connection =
      Connection(Cluster(Uri.parse(SolanaConfig.rpc)));

  Future<void> getPoolsInfo() async {
    List<Pool> list = [];
    var dune = await OffchainApi.getDuneStat();
    
    for (var pool in poolsData) {

      final duneStat = dune.where((element) => element.symbol == pool.symbol).first;

      final apy = duneStat.feeUsd / duneStat.balanceUsd;

      list.add(
        Pool(
          symbol: pool.symbol, 
          logoUrl: pool.logoUrl, 
          mint: pool.mint, 
          pythOracle: pool.pythOracle, 
          decimals: pool.decimals,
          liquidity: duneStat.balanceUsd.toStringAsFixed(2).formatNumWithCommas(),
          volume: duneStat.volumeUsd.toStringAsFixed(2).formatNumWithCommas(),
          fees: duneStat.feeUsd.roundToSignificantFigures(2).formatNumWithCommas(),
          apy: apy.toStringAsFixed(2).formatNumWithCommas()
        )
      );
    }

    emit(HomeLiquidityScreenState(pools: list));
  }

}

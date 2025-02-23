import 'dart:convert';

import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/models/pool_pda.dart';
import 'package:spice_ui/service/config.dart';
import 'package:spice_ui/service/spice_program.dart';

class ChainApi {

  static final Connection connection = Connection(Cluster(Uri.parse(SolanaConfig.rpc)));

  static Future<List<PoolPda>> getPoolsInfo() async {
    final List<ProgramAccount> poolsRaw = await connection.getProgramAccounts(SpiceProgram.programId, config: GetProgramAccountsConfig(filters: [const DataSize(dataSize: 145)]));
    return poolsRaw.map((account) => PoolPda.fromAccountData(base64.decode(account.account.data[0]))).toList();
  }

}

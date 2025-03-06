import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/adapter/controller/adapter_states.dart';
import 'package:spice_ui/portfolio/cubit/portfolio_cubit.dart';
import 'package:spice_ui/service/config.dart';
import 'package:url_launcher/url_launcher.dart';
import '../wallet_module.dart' as wallet_module;
import 'package:js/js_util.dart';
import 'dart:async';

class AdapterCubit extends Cubit<AdapterStates> {
  final PortfolioCubit portfolioCubit;
  AdapterCubit(this.portfolioCubit) : super(UnconnectedAdapterState());

  final Connection connection =
      Connection(Cluster(Uri.parse(SolanaConfig.rpc)));

  String? signer;
  Map? balances;

  Future<void> connect() async {
    if (!wallet_module.isPhantomInstalled()) {
      await launchUrl(Uri.parse("https://phantom.app/download"));
      return;
    }

    await promiseToFuture(wallet_module.connect());
    signer = wallet_module.address();
    
    emit(ConnectedAdapterState(address: wallet_module.address()));

    if (!portfolioCubit.isClosed) {
      portfolioCubit.loadingPortfolio(signer: wallet_module.address());
    }
  }

  Future<void> disconnect() async {
    wallet_module.disconnect();

    if (!portfolioCubit.isClosed) {
      portfolioCubit.clearPortfolioScreen();
    }

    emit(UnconnectedAdapterState());
  }

  Future<String> signAndSendTransaction(Transaction transaction) async {
    var signature = await promiseToFuture(wallet_module.sendTransaction(transaction.serialize().asUint8List()));
    return signature;
  }
}

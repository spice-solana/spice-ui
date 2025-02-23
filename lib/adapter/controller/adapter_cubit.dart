import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/adapter/controller/adapter_states.dart';
import 'package:spice_ui/portfolio/cubit/portfolio_cubit.dart';
import 'package:spice_ui/service/config.dart';
import 'package:url_launcher/url_launcher.dart';
import '../wallet_module.dart' as wm;
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
    if (!wm.isPhantomInstalled()) {
      await launchUrl(Uri.parse("https://phantom.app/download"));
      return;
    }

    await promiseToFuture(wm.connect());
    signer = wm.address();
    
    emit(ConnectedAdapterState(address: wm.address()));

    if (!portfolioCubit.isClosed) {
      portfolioCubit.loadingPortfolio(signer: wm.address());
    }
  }

  Future<void> disconnect() async {
    wm.disconnect();

    if (!portfolioCubit.isClosed) {
      portfolioCubit.clearPortfolioScreen();
    }

    emit(UnconnectedAdapterState());
  }

  Future<Transaction> signTransaction(Transaction transaction) async {
    var signedTransaction = await promiseToFuture(wm.signTransaction(transaction.serialize().asUint8List()));
    return Transaction.deserialize(signedTransaction);
  }
}

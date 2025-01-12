import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_web3/solana_web3.dart';
import 'package:spice_ui/adapter/controller/adapter_states.dart';
import '../wallet_module.dart' as wm;
import 'package:js/js_util.dart';
import 'dart:async';

class AdapterCubit extends Cubit<AdapterStates> {
  AdapterCubit({state}) : super(UnconnectedAdapterState());

  Future<void> connect() async {
    await promiseToFuture(wm.connect());
    emit(ConnectedAdapterState(address: wm.address()));
  }

  Future<void> disconnect() async {
    wm.disconnect();
    emit(UnconnectedAdapterState());
  }

  Future<Transaction> signTransaction(Transaction transaction) async {
    var signedTransaction = await promiseToFuture(wm.signTransaction(transaction.serialize().asUint8List()));
    return Transaction.deserialize(signedTransaction);
  }

}

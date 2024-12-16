import 'wallet_module.dart' as wm;
import 'package:js/js_util.dart';
import 'package:solana_web3/solana_web3.dart';
import 'dart:async';

class PhantomAdapter {

  static Future<String> connect() async {
    await promiseToFuture(wm.connect());
    return wm.address();
  }

  static void disconnect() => wm.disconnect();

  static Future signTransaction(Transaction transaction) async {
    var signedTransaction = await promiseToFuture(wm.signTransaction(transaction.serialize().asUint8List()));
    print(signedTransaction['signature']);
    return signedTransaction;
  }

}
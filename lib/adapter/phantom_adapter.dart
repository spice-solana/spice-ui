// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class PhantomAdapter {

  static bool _isPhantomInstalled() =>
      js.context.hasProperty('solana') && js.context['solana']['isPhantom'];

  static Future<String> connect() async {
    if (_isPhantomInstalled()) {
      try {
        final response = js.context['solana'] as js.JsObject;

        final options = js.JsObject.jsify({
          'onlyIfTrusted': false,
          'app': {
            'name': 'Spice',
            'icon': 'https://76btz57hb42jsjrp7fil36dvtnaouxcoumf4olflbx4utsvl3kxq.arweave.net/_4M89-cPNJkmL_lQvfh1m0DqXE6jC8csqw35Scqr2q8'
          }
        });

        await response.callMethod('connect', [options]);

        var publicKey = response['publicKey'];

        publicKey = await _waitForPublicKey(response);

        return publicKey;
      } catch (e) {
        return "Connection failed: $e";
      }
    } else {
      await launchUrl(Uri.parse('https://phantom.app'));
      return "Phantom Wallet is not installed.";
    }
  }


  static Future<String> _waitForPublicKey(js.JsObject response) async {
    Completer<String> completer = Completer();

    if (response['publicKey'] != null) {
      completer.complete(response['publicKey'].toString());
    } else {
      Timer.periodic(const Duration(seconds: 1), (timer) async {
        var currentPublicKey = response['publicKey'];
        if (currentPublicKey != null) {
          completer.complete(currentPublicKey.toString());
          timer.cancel();
        }
      });
    }

    return completer.future;
  }

  static Future disconnect() async {
      try {
        final response = js.context['solana'] as js.JsObject;

        await response.callMethod('disconnect');

        return null;
      } catch (e) {
        
      }
    }

  static Future<Uint8List?> signTransaction(Uint8List transactionData) async {
  try {
    final response = js.context['solana'] as js.JsObject;

    // Phantom's signTransaction expects a serialized transaction (Uint8List)
    final signedTransaction = await response.callMethod('signTransaction', [
      transactionData
    ]);

    // Parse the result back to Uint8List
    return Uint8List.fromList(signedTransaction['signature']);
  } catch (e) {
    print("Error signing transaction: $e");
    return null;
  }
}

static Future<List<Uint8List>?> signAllTransactions(
    List<Uint8List> transactions) async {
  try {
    final response = js.context['solana'] as js.JsObject;

    // Phantom's signAllTransactions expects an array of serialized transactions
    final signedTransactions = await response.callMethod(
        'signAllTransactions', [js.JsArray.from(transactions)]);

    // Parse the result back to a list of Uint8List
    return signedTransactions.map((tx) {
      return Uint8List.fromList(tx['signature']);
    }).toList();
  } catch (e) {
    print("Error signing all transactions: $e");
    return null;
  }
}

}

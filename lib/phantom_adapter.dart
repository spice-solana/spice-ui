// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class PhantomAdapter {

  static bool _isPhantomInstalled() =>
      js.context.hasProperty('solana') && js.context['solana']['isPhantom'];

  static Future<String> connect() async {
    if (_isPhantomInstalled()) {
      try {
        final response = js.context['solana'] as js.JsObject;

        await response.callMethod('connect');

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

}

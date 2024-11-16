// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
//import 'package:url_launcher/url_launcher.dart';


class PhantomAdapter {

  static bool _isPhantomInstalled() => js.context.hasProperty('solana') && js.context['solana']['isPhantom'];

  static Future<String> connect() async {
    if (_isPhantomInstalled()) {
      try {
        
        final response = await js.context['solana'] as js.JsObject;
        await response.callMethod('connect');
        final publicKey = response['publicKey'].toString();
        return publicKey;

      } catch (e) {
          return "Connection failed: $e";
      }
    } else {
      //await launchUrl(Uri.parse('https://phantom.app'));
      return "Phantom Wallet is not installed.";
    }
  }

}
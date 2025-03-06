@JS('walletModule')
library wallet_module;

import 'package:js/js.dart';

@JS('isPhantomInstalled')
external bool isPhantomInstalled();

@JS('connect')
external Future<void> connect();

@JS('address')
external String address();

@JS('disconnect')
external void disconnect();

@JS('sendTransaction')
external Future<dynamic> sendTransaction(tx);

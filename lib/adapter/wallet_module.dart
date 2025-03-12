@JS('walletModule')
library wallet_module;

import 'package:js/js.dart';

@JS('isBackpackInstalled')
external bool isBackpackInstalled();

@JS('connect')
external Future<void> connect();

@JS('address')
external String address();

@JS('disconnect')
external void disconnect();

@JS('sendTransaction')
external Future<dynamic> sendTransaction(tx);

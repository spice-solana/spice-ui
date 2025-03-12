import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spice_ui/service/offchain_api.dart';


void main() {
  
  test("get prices for pools tokens", () async {
    var prices = await OffchainApi.getPriceForPoolsTokens();
    debugPrint(prices.toString());
  });

  test("get dune state", () async {
    var stat = await OffchainApi.getDuneStat();
    debugPrint(stat.first.feeUsd.toString());
  });


}
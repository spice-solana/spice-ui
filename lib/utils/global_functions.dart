import 'dart:math';
import 'package:spice_ui/models/portfolio.dart';
import 'package:spice_ui/utils/constants.dart';

String truncateToDecimals(num number, int decimals) {
  String result = number.toStringAsFixed(decimals);
  
  if (result.contains('.')) {
    result = result.replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
  }

  return result;
}

String extractValue(String input, String key) {
  final regex = RegExp('$key: ([0-9]+)');
  final match = regex.firstMatch(input);
  return match != null ? match.group(1) ?? '' : '';
}

String? extractErrorMessage(String input) {
  final regex = RegExp('Error Message: ([^,]+)');
  final match = regex.firstMatch(input);
  return match?.group(1);
}

String calculatingEarn({required int amount, required num poolCumulativeYield, required num userLastCumulativeYield, required num initialLiquidity, required int pendingYield, required int decimals}) {
    if (amount == 0) {
      return '0';
    }
    var cumulativeYield = (poolCumulativeYield - userLastCumulativeYield) / cumulativeYieldScaleConstant;
    var cumulativeYieldPerToken = cumulativeYield / initialLiquidity;
    var earn = (amount * cumulativeYieldPerToken + pendingYield) / pow(10, decimals);
    return truncateToDecimals(earn, decimals);
}

num calculatingAirdrop({required Position position}) {
  if (position.pool.mint == "So11111111111111111111111111111111111111112") {
    return num.parse(position.liquidity) * 300;
  }
  return num.parse(position.liquidity) * 2;
}
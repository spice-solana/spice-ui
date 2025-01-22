String truncateToDecimals(num number, int decimals) {
  if (number.toString().split('.').last.length > decimals) {
    return number.toStringAsFixed(decimals);
  }

  return number.toString();
}

String extractValue(String input, String key) {
  final regex = RegExp('$key: ([0-9]+)');
  final match = regex.firstMatch(input);
  return match != null ? match.group(1) ?? '' : '';
}

String extractErrorMessage(String input) {
  final regex = RegExp('Error Message: ([^,]+)');
  final match = regex.firstMatch(input);
  return match != null ? match.group(1) ?? '' : '';
}
import 'package:flutter_test/flutter_test.dart';
import 'package:spice_ui/utils/global_functions.dart';


void main() {
  
  test("truncate to decimals", () {
    var tr = truncateToDecimals(0.057000, 9);
    print(tr);
  });

}
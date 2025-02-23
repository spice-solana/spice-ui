import 'package:flutter_test/flutter_test.dart';
import 'package:spice_ui/service/chain_api.dart';


void main() {
  
  test("get pools info", () async {
    var pools = await ChainApi.getPoolsInfo();
    expect(pools.first.isActive, equals(true));
  });


}
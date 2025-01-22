import 'dart:convert';

import 'package:http/http.dart' as http;


class OffchainApi {

  static Future getPrices({required List<String> tokens}) async {

      var uri = "https://api.jup.ag/price/v2?ids=";

      uri += tokens.join(',');

      try {
        var response = await http.get(Uri.parse(uri));

        if (response.statusCode != 200) {
          print("Error: ${response.statusCode}, ${response.body}");
          return {};
        }

        final Map<String, dynamic> jsonDecode = json.decode(response.body)['data'];
        return jsonDecode;

      } catch (e) {
        print("Error: ${e.toString()}");
        return {};
      }
    }

}
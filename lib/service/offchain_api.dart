import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/models/dune.dart';

class OffchainApi {

  static Future getPriceForPoolsTokens() async {
    var tokens = poolsData.map((data) => data.mint == "Gh9ZwEmdLJ8DscKNTkTqPbNwLNNBjuSzaG9Vp2KGtKJr" ? "EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v" : data.mint).toList();

    var uri = "https://api.jup.ag/price/v2?ids=";

    uri += tokens.join(',');

    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode != 200) {
        debugPrint("Error: ${response.statusCode}, ${response.body}");
        return {};
      }

      final Map<String, dynamic> jsonDecode = json.decode(response.body)['data'];
      return jsonDecode;
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return {};
    }
  }

  static Future<List<Dune>> getDuneStat() async {
    var uri = Uri.parse("https://api.dune.com/api/v1/query/4841560/results?limit=100");
    var api = "pW4mdu3UGFmfRlVSpUB6yi0BPZr45qJu";

    final response = await http.get(uri, headers: {"X-Dune-Api-Key": api});
    final List jsonDecode = json.decode(response.body)['result']['rows'];
    return jsonDecode.map((json) => Dune.fromJson(json)).toList();
  }
  
}

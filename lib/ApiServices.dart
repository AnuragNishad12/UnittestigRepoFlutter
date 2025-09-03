import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as client;
import 'package:riverpoddemo/DogModel.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final http.Client client; // <-- add this

  ApiServices({http.Client? client}) : client = client ?? http.Client();
  // if no client is given, use the real one

  String baseUrl = "https://dog.ceo/api/breeds/image/random";

  Future<DogModel> fetchRandomDog() async {
    final url = Uri.parse(baseUrl);
    final resp = await client.get(url);
    if (resp.statusCode == 200) {
      final jsonBody = jsonDecode(resp.body);
      print("BodyData" + jsonBody.toString());
      return DogModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch dog image: ${resp.statusCode}');
    }
  }
}

final dogApiServiceProvider = Provider((ref) => ApiServices());

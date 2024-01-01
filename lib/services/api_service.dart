import 'dart:convert';

import 'package:eventmobile/services/storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  final String _baseUrl = 'https://eventapp-dev-ggxr.4.us-1.fl0.io/api';

  static Future<Map<String, String>> headers() async {
    var token = await UserStorage.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return headers;
  }

  get url => _baseUrl;

  Future<Response> get(String endpoint) async {
    final url = Uri.parse("$_baseUrl$endpoint");
    final response = await http.get(
      url,
      headers: await headers(),
    );
    return response;
  }

  Future<Response> post(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    final url = Uri.parse("$_baseUrl$endpoint");
    final response = await http.post(
      url,
      body: jsonEncode(body),
      headers: await headers(),
    );
    // print(response.body);
    return response;
  }
}

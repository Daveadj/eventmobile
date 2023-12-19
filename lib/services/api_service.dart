import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  final String _baseUrl = 'https://eventapp-dev-ggxr.4.us-1.fl0.io/api';
  static const Map<String, String> defaultheader = {
    'Content-Type': 'application/json',
  };

  get url => _baseUrl;

  Future<Response> get(String endpoint) async {
    final url = Uri.parse("$_baseUrl$endpoint");
    final response = await http.get(
      url,
      headers: defaultheader,
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
      headers: defaultheader,
    );
    // print(response.body);
    return response;
  }
}

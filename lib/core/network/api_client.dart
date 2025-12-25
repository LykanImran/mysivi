import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_endpoints.dart';

class ApiClient {
  final http.Client _client;

  ApiClient([http.Client? client]) : _client = client ?? http.Client();

  Uri _uri(String path) => Uri.parse('${ApiEndpoints.baseUrl}$path');

  Future<Map<String, dynamic>> get(String path) async {
    final res = await _client.get(_uri(path));
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  // This is a tiny wrapper; extend as needed for error handling, headers, etc.
}

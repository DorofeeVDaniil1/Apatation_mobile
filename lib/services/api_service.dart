import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class ApiService {
  final _logger = Logger('ApiService');
  final String baseUrl;
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'tuna-skip-browser-warning': 'true',
  };

  ApiService({required this.baseUrl});

  void setAuthToken(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      _logger.info('GET $endpoint: ${response.statusCode}');
      return _handleResponse(response);
    } catch (e) {
      _logger.severe('GET $endpoint error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: json.encode(body),
      );
      _logger.info('POST $endpoint: ${response.statusCode}');
      return _handleResponse(response);
    } catch (e) {
      _logger.severe('POST $endpoint error: $e');
      rethrow;
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: response.body,
      );
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException: $statusCode - $message';
}

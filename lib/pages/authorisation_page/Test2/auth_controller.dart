// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'providers.dart';

class AuthController {
  final _logger = Logger('AuthController');
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final WidgetRef ref;

  static const String BASE_URL = "https://tgrj0i-37-29-92-61.ru.tuna.am";
  static const String LOGIN_URL = "$BASE_URL/api/login";

  AuthController(this.ref);

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'tuna-skip-browser-warning': 'true',
      };

  Future<bool> tryAutoLogin() async {
    final tokens = await _getTokens();
    final accessToken = tokens['access_token'] ?? '';

    _logger.info("AutoLogin: найден токен: $accessToken");
    if (accessToken.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(LOGIN_URL),
          headers: _headers,
          body: json.encode({'access_token': accessToken}),
        );
        final decodedResponse = utf8.decode(response.bodyBytes);
        _logger
            .info("AutoLogin: ответ ${response.statusCode} - $decodedResponse");

        if (response.statusCode == 200) {
          _handleSuccessfulLogin(accessToken);
          return true;
        }
      } catch (e) {
        _logger.severe("AutoLogin: исключение $e");
      }
    }
    return false;
  }

  Future<(bool, String)> login(String login, String password) async {
    try {
      final response = await http.post(
        Uri.parse(LOGIN_URL),
        headers: _headers,
        body: json.encode({'login': login, 'password': password}),
      );
      _logger.info("Login: ответ ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _logger.info("Login: полученные данные $data");
        await _saveTokens(data['access_token']);
        _handleSuccessfulLogin(data['access_token']);
        return (true, '');
      } else if (response.statusCode == 401) {
        return (false, 'Неверный логин или пароль');
      } else {
        return (false, 'Ошибка авторизации');
      }
    } catch (e) {
      _logger.severe("Login: исключение $e");
      return (false, 'Ошибка соединения. Попробуйте позже.');
    }
  }

  void _handleSuccessfulLogin(String accessToken) {
    final tokenParts = accessToken.split('_');
    if (tokenParts.isNotEmpty && tokenParts.last == 'admin') {
      ref.read(isAdminProvider.notifier).state = true;
    }
  }

  Future<void> _saveTokens(String accessToken) async {
    await _secureStorage.write(key: 'access_token', value: accessToken);
  }

  Future<Map<String, String>> _getTokens() async {
    final accessToken = await _secureStorage.read(key: 'access_token') ?? '';
    return {
      'access_token': accessToken,
    };
  }
}

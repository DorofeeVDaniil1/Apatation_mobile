// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../../models/user.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../services/api_service.dart';
import '../../../services/user_service.dart';

class AuthController {
  final _logger = Logger('AuthController');
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final WidgetRef ref;
  late final UserService _userService;

  AuthController(this.ref) {
    final apiService =
        ApiService(baseUrl: 'https://tgrj0i-37-29-92-61.ru.tuna.am');
    _userService = UserService(apiService);
  }

  Future<bool> tryAutoLogin() async {
    final token = await _getToken();
    if (token.isEmpty) return false;

    try {
      await _handleSuccessfulLogin(token);
      return true;
    } catch (e) {
      _logger.severe('AutoLogin error: $e');
      return false;
    }
  }

  Future<(bool, String)> login(String login, String password) async {
    try {
      final token = await _userService.login(login, password);
      await _handleSuccessfulLogin(token);
      return (true, '');
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        return (false, 'Неверный логин или пароль');
      }
      return (false, 'Ошибка авторизации');
    } catch (e) {
      _logger.severe('Login error: $e');
      return (false, 'Ошибка соединения. Попробуйте позже.');
    }
  }

  Future<void> _handleSuccessfulLogin(String token) async {
    await _saveToken(token);
    ref.read(authTokenProvider.notifier).state = token;

    // Загружаем профиль пользователя
    final user = await _userService.getProfile();
    ref.read(userProvider.notifier).updateUser(user);
  }

  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: 'access_token', value: token);
  }

  Future<String> _getToken() async {
    return await _secureStorage.read(key: 'access_token') ?? '';
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'access_token');
    ref.read(authTokenProvider.notifier).state = null;
    ref.read(userProvider.notifier).updateUser(
          const User(name: '', level: 0, points: 0),
        );
  }
}

import 'api_service.dart';
import '../models/user.dart';

class UserService {
  final ApiService _api;
  static const String _profileEndpoint = '/api/user/profile';
  static const String _loginEndpoint = '/api/login';
  static const String _registerEndpoint = '/api/register';
  static const String _resetPasswordEndpoint = '/api/reset-password';

  UserService(this._api);

  Future<String> login(String login, String password) async {
    final response = await _api.post(_loginEndpoint, {
      'login': login,
      'password': password,
    });
    return response['access_token'] as String;
  }

  Future<User> getProfile() async {
    final response = await _api.get(_profileEndpoint);
    return User.fromJson(response);
  }

  Future<void> register({
    required String login,
    required String password,
    required String email,
    required String name,
  }) async {
    await _api.post(_registerEndpoint, {
      'login': login,
      'password': password,
      'email': email,
      'name': name,
    });
  }

  Future<void> resetPassword(String email) async {
    await _api.post(_resetPasswordEndpoint, {
      'email': email,
    });
  }
}

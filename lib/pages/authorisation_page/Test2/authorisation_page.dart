// ignore_for_file: deprecated_member_use

import 'package:anhk/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/is_admin_provider.dart';
import '../../onboarding/onboarding_page.dart';
import 'auth_controller.dart';
import '../../forgot/reset/forgot_password_page.dart';

class AuthorizationPage extends ConsumerStatefulWidget {
  const AuthorizationPage({super.key});

  @override
  ConsumerState<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends ConsumerState<AuthorizationPage> {
  bool _obscureText = true;
  bool _isLoading = false;
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = AuthController(ref);
    _tryAutoLogin();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _tryAutoLogin() async {
    setState(() => _isLoading = true);
    final success = await _authController.tryAutoLogin();
    setState(() => _isLoading = false);

    if (success) {
      _navigateToHome();
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<void> _handleLogin() async {
    // Проверка на demo доступ
    if (_loginController.text == 'demo' && _passwordController.text == 'demo') {
      _navigateToHome();
      return;
    }

    // Валидация полей
    if (_loginController.text.isEmpty || _passwordController.text.isEmpty) {
      _showError('Пожалуйста, заполните все поля');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final (success, message) = await _authController.login(
        _loginController.text,
        _passwordController.text,
      );

      if (success) {
        _navigateToHome();
      } else {
        _showError(message);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnboardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final isAdmin = ref.watch(isAdminProvider);
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            color: const Color(0xFFF6F7FB),
            child: Column(
              children: [
                // Dark header with logo
                Container(
                  height: 213,
                  color: const Color(0xFF0D1720),
                  child: Center(
                    child: Image.asset(
                      'assets/images/Frame_logo.png',
                      width: 160,
                      height: 160,
                    ),
                  ),
                ),
                // Main content area
                Expanded(
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/Background.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.56),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Login form
          if (!_isLoading)
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _loginController,
                      decoration: const InputDecoration(
                        labelText: 'Логин',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() => _obscureText = !_obscureText);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFCC00),
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Войти'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: const Text('Забыли пароль?'),
                    ),
                  ],
                ),
              ),
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

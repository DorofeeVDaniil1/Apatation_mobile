import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_controller.dart';
import '../../main_page/menu_page.dart'; // Убедитесь, что путь правильный
import 'forgot_password_page.dart';

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
    final success = await _authController.tryAutoLogin();
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
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
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

          // Login Form
          Positioned.fill(
            top: 296,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Авторизация',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Login input
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Логин',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: '*',
                              style: TextStyle(color: Color(0xFFC10D0D)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: TextField(
                          controller: _loginController,
                          decoration: const InputDecoration(
                            hintText: 'Логин',
                            hintStyle: TextStyle(
                              color: Color(0x4C000000),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 45),

                  // Password input
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Пароль',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: '*',
                              style: TextStyle(color: Color(0xB2C10D0D)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Пароль',
                            hintStyle: const TextStyle(
                              color: Color(0x4C000000),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 17,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: const Color(0x4C000000),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 90),

                  // Login button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFCC00),
                      foregroundColor: const Color(0xFF1B1918),
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF1B1918)),
                            ),
                          )
                        : const Text(
                            'Вход',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                  ),
                  const SizedBox(height: 30),

                  // Forgot password
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Забыли пароль?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Status bar content
        ],
      ),
    );
  }
}

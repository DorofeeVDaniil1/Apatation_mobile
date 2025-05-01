import 'package:flutter/material.dart';
import '../../../../design/colors.dart';

class AuthForm extends StatelessWidget {
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final bool isLoading;
  final VoidCallback onLoginPressed;
  final VoidCallback onTogglePasswordVisibility;

  const AuthForm({
    super.key,
    required this.loginController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.isLoading,
    required this.onLoginPressed,
    required this.onTogglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          const Center(
            child: Text(
              "Авторизация",
              style: TextStyle(fontFamily: "Europe", fontSize: 24),
            ),
          ),
          const SizedBox(height: 20),
          _buildLoginField(),
          const SizedBox(height: 30),
          _buildPasswordField(),
          const SizedBox(height: 50),
          _buildLoginButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLoginField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text("Логин", style: TextStyle(fontFamily: "Europe")),
        ),
        TextField(
          controller: loginController,
          decoration: InputDecoration(
            hintText: 'Логин',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          style: const TextStyle(fontFamily: 'Europe'),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text("Пароль", style: TextStyle(fontFamily: "Europe")),
        ),
        TextField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Пароль',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible
                    ? Icons.remove_red_eye_outlined
                    : Icons.remove_red_eye,
                color: isPasswordVisible ? yellow : Colors.grey,
              ),
              onPressed: onTogglePasswordVisibility,
            ),
          ),
          style: const TextStyle(fontFamily: 'Europe'),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: isLoading ? null : onLoginPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: black,
        backgroundColor: yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        textStyle: const TextStyle(fontSize: 16, fontFamily: 'Europe'),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: isLoading ? const CircularProgressIndicator() : const Text('Вход'),
    );
  }
}

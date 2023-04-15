import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const valueKey = ValueKey("LoginPage");

  const LoginPage({
    super.key,
    required this.onSuccessLogin,
    required this.onRegister,
  });

  final void Function() onSuccessLogin;
  final void Function() onRegister;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("LoginPage"),
            const SizedBox(
              height: 24.0,
            ),
            OutlinedButton(
              onPressed: onRegister,
              child: const Text("Register"),
            ),
            OutlinedButton(
              onPressed: onSuccessLogin,
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

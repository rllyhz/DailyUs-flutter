import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  static String routeName = "/register";

  const RegisterPage({
    super.key,
    required this.onLogin,
    required this.onSuccessRegister,
  });

  final void Function() onLogin;
  final void Function() onSuccessRegister;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("RegisterPage"),
            const SizedBox(
              height: 24.0,
            ),
            OutlinedButton(
              onPressed: onSuccessRegister,
              child: const Text("Register"),
            ),
            OutlinedButton(
              onPressed: onLogin,
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

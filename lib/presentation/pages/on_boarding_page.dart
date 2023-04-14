import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  static String routeName = "/boarding";

  const OnBoardingPage({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  final void Function() onLogin;
  final void Function() onRegister;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("OnBoardingPage"),
            const SizedBox(
              height: 24.0,
            ),
            OutlinedButton(
              onPressed: onRegister,
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

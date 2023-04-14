import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  static String routeName = "/";

  const MainPage({super.key, required this.onLogout});

  final void Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("MainPage"),
            const SizedBox(
              height: 24.0,
            ),
            OutlinedButton(
              onPressed: onLogout,
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}

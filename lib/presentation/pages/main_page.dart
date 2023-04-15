import 'dart:math';

import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  static String routeName = "/";

  const MainPage({
    super.key,
    required this.onLogout,
    required this.onDetail,
  });

  final void Function() onLogout;
  final void Function(String) onDetail;

  @override
  Widget build(BuildContext context) {
    final storyId = Random(20).nextInt(100).toString();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("MainPage"),
            const SizedBox(
              height: 24.0,
            ),
            OutlinedButton(
              onPressed: () {
                onDetail(storyId);
              },
              child: Text("Go to Detail: $storyId"),
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

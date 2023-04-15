import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.storyId,
    required this.onNavigateBack,
  });

  final String storyId;
  final void Function() onNavigateBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("DetailPage"),
            Text("Story with id $storyId"),
            const SizedBox(
              height: 24.0,
            ),
            OutlinedButton(
              onPressed: onNavigateBack,
              child: const Text("Back to Main"),
            ),
          ],
        ),
      ),
    );
  }
}

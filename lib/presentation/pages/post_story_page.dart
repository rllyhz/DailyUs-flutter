import 'package:flutter/material.dart';

class PostStoryPage extends StatelessWidget {
  static const valueKey = ValueKey("PostStoryPage");

  const PostStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text("PostStory UI"),
      ),
    );
  }
}

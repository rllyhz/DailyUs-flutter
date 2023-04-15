import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const valueKey = ValueKey("ProfilePage");

  const ProfilePage({super.key, required this.onLogout});

  final void Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: const Center(
        child: Text("Profile UI"),
      ),
    );
  }
}

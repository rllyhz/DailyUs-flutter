import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const valueKey = ValueKey("HomePage");

  const HomePage({super.key, required this.onDetail});

  final void Function(String) onDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text("Home UI"),
      ),
    );
  }
}

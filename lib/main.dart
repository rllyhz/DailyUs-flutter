import 'package:daily_us/daily_us_app.dart';
import 'package:daily_us/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:daily_us/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    DailUsApp(
      titleApp: FlavorConfig.instance.values.titleApp,
    ),
  );
}

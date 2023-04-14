import 'package:daily_us/common/secrets.dart';
import 'package:daily_us/common/ui/decorations.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:daily_us/injection.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeLight,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppSecretLoader.load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          var secret = snapshot.data;

          return Center(
            child: Text(secret!.baseUrl),
          );
        }
        return Center(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: background,
          ),
        );
      },
    );
  }
}

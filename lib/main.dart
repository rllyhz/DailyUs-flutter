import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/presentation/pages/splash_page.dart';
import 'package:daily_us/routes/daily_us_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:daily_us/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DailyUsRouterDelegate appRouterDelegate;

  @override
  void initState() {
    super.initState();

    appRouterDelegate = DailyUsRouterDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Router(
        routerDelegate: appRouterDelegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}

import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/domain/usecases/get_auth_info.dart';
import 'package:daily_us/routes/daily_us_route_information_parser.dart';
import 'package:daily_us/routes/daily_us_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:daily_us/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const DailUsApp());
}

class DailUsApp extends StatefulWidget {
  const DailUsApp({super.key});

  @override
  State<DailUsApp> createState() => _DailUsAppState();
}

class _DailUsAppState extends State<DailUsApp> {
  late DailyUsRouterDelegate appRouterDelegate;
  late DailyUsRouteInformationParser appRouteInformationParser;

  @override
  void initState() {
    super.initState();

    appRouterDelegate = DailyUsRouterDelegate(
      getAuthInfo: di.locator<GetAuthInfo>(),
    );
    appRouteInformationParser = DailyUsRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      routerDelegate: appRouterDelegate,
      routeInformationParser: appRouteInformationParser,
      backButtonDispatcher: RootBackButtonDispatcher(),
    );
  }
}

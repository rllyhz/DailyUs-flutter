import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/logger.dart';
import 'package:daily_us/domain/entities/localization.dart';
import 'package:daily_us/domain/usecases/get_auth_info.dart';
import 'package:daily_us/domain/usecases/get_localization_data.dart';
import 'package:daily_us/domain/usecases/update_localization_data.dart';
import 'package:daily_us/presentation/bloc/detail/detail_bloc.dart';
import 'package:daily_us/presentation/bloc/home/home_bloc.dart';
import 'package:daily_us/presentation/bloc/login/login_bloc.dart';
import 'package:daily_us/presentation/bloc/post/post_bloc.dart';
import 'package:daily_us/presentation/bloc/profile/profile_bloc.dart';
import 'package:daily_us/presentation/bloc/register/register_block.dart';
import 'package:daily_us/routes/daily_us_route_information_parser.dart';
import 'package:daily_us/routes/daily_us_router_delegate.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:daily_us/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late GetLocalizationData getLocalizationDataUsecase;
  late UpdateLocalizationData updateLocalizationDataUsecase;

  late Localization localizationData;

  @override
  void initState() {
    super.initState();
    updateLocalizationDataUsecase = di.locator<UpdateLocalizationData>();
    getLocalizationDataUsecase = di.locator<GetLocalizationData>();

    var currLocalization = getLocalizationDataUsecase.execute();
    localizationData = Localization(
      currentLocale: currLocalization.currentLocale,
    );

    appRouterDelegate = DailyUsRouterDelegate(
      getAuthInfoUsecase: di.locator<GetAuthInfo>(),
      onUpdateLocalization: _updateLanguage,
    );

    appRouteInformationParser = DailyUsRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => di.locator<LoginBloc>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => di.locator<RegisterBloc>(),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => di.locator<HomeBloc>(),
        ),
        BlocProvider<DetailBloc>(
          create: (_) => di.locator<DetailBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => di.locator<ProfileBloc>(),
        ),
        BlocProvider<PostBloc>(
          create: (_) => di.locator<PostBloc>(),
        ),
      ],
      child: MaterialApp.router(
        locale: Locale(
          localizationData.currentLocale.languageCode,
        ),
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
      ),
    );
  }

  void _updateLanguage(
    Locale locale,
    String successMessage,
    String faildedMessage,
  ) {
    try {
      var newLocalizationData = Localization(currentLocale: locale);
      updateLocalizationDataUsecase.execute(newLocalizationData);

      showToast(successMessage, isError: false);

      setState(() {
        localizationData = newLocalizationData;
      });
      //
    } catch (e) {
      Logger.logWithTag("Failed to update localization", e.toString());
      showToast(faildedMessage);
    }
  }
}

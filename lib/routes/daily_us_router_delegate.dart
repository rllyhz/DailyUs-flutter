import 'package:daily_us/data/models/page_configuration.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/usecases/get_auth_info.dart';
import 'package:daily_us/presentation/pages/anim/slide_animation_page.dart';
import 'package:daily_us/presentation/pages/detail_page.dart';
import 'package:daily_us/presentation/pages/login_page.dart';
import 'package:daily_us/presentation/pages/main_page.dart';
import 'package:daily_us/presentation/pages/on_boarding_page.dart';
import 'package:daily_us/presentation/pages/register_page.dart';
import 'package:daily_us/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';

class DailyUsRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  DailyUsRouterDelegate({
    required this.getAuthInfoUsecase,
  }) : _navigatorKey = GlobalKey<NavigatorState>();

  final GetAuthInfo getAuthInfoUsecase;

  List<Page> historyStack = [];
  bool? isUnknown;
  bool? isLoggedIn;
  bool onBoarding = false;
  bool isRegister = false;
  String? storyId;
  AuthInfo? authInfo;

  bool isLauchMainFromSplash = true;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        var didPop = route.didPop(result);
        if (!didPop) {
          return true;
        }

        final page = route.settings as MaterialPage;

        if (page.key == SplashPage.valueKey) {
          return false;
        }
        if (page.key == LoginPage.valueKey) {
          isLoggedIn = false;
          onBoarding = true;
        }
        if (page.key == RegisterPage.valueKey) {
          isLoggedIn = false;
          isRegister = false;
          onBoarding = true;
        }
        if (page.key == DetailPage.valueKey) {
          storyId = null;
        }

        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    if (configuration.isUnknownPage) {
      isUnknown = true;
    } else if (configuration.isOnBoardingPage) {
      onBoarding = true;
    } else if (configuration.isRegisterPage) {
      isRegister = true;
    } else if (configuration.isLoginPage) {
      isLoggedIn = false;
    } else if (configuration.isMainPage ||
        configuration.isLoginPage ||
        configuration.isSplashPage) {
      isUnknown = false;
      storyId = null;
      isRegister = false;
    } else if (configuration.isDetailPage) {
      isUnknown = false;
      isRegister = false;
      storyId = configuration.storyId.toString();
    } else {
      debugPrint(' Could not set new route');
    }

    notifyListeners();
  }

  @override
  PageConfiguration? get currentConfiguration {
    if (isLoggedIn == null) {
      return PageConfiguration.splash();
    } else if (onBoarding == true) {
      return PageConfiguration.onBoarding();
    } else if (isRegister == true) {
      return PageConfiguration.register();
    } else if (isLoggedIn == false) {
      return PageConfiguration.login();
    } else if (isUnknown == true) {
      return PageConfiguration.unknown();
    } else if (storyId == null) {
      return PageConfiguration.main();
    } else if (storyId != null) {
      return PageConfiguration.detail(storyId!);
    } else {
      return null;
    }
  }

  List<Page> get _splashStack => [
        MaterialPage(
          key: SplashPage.valueKey,
          child: SplashPage(
            runPreparationCallback: () async {
              // run task to check if user already logged in
              authInfo = getAuthInfoUsecase.execute();

              if (authInfo != null && authInfo!.isAlreadyLoggedIn) {
                isRegister = false;
                onBoarding = false;
                isLoggedIn = true;
              } else {
                isLoggedIn = false;
                isRegister = false;
                onBoarding = true;
              }
            },
            onAnimationEnd: () {
              // notify state correspondingly to the auth info's state
              notifyListeners();
            },
          ),
        ),
      ];

  List<Page> get _loggedOutStack => [
        SlideAnimationPage(
          direction: SlideAnimationPage.bottomToTop,
          key: OnBoardingPage.valueKey,
          child: OnBoardingPage(
            onLogin: () {
              isRegister = false;
              isLoggedIn = false;
              onBoarding = false;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              isLoggedIn = false;
              onBoarding = false;
              notifyListeners();
            },
          ),
        ),
        if (onBoarding == false && isRegister == false && isLoggedIn == false)
          MaterialPage(
            key: LoginPage.valueKey,
            child: LoginPage(
              onSuccessLogin: (newAuthInfo) {
                isLoggedIn = true;
                onBoarding = false;
                isLauchMainFromSplash = false;
                authInfo = newAuthInfo;
                notifyListeners();
              },
            ),
          ),
        if (onBoarding == false && isLoggedIn == false && isRegister == true)
          MaterialPage(
            key: RegisterPage.valueKey,
            child: RegisterPage(
              onSuccessRegister: () {
                isRegister = false;
                onBoarding = false;
                notifyListeners();
              },
            ),
          ),
      ];

  List<Page> get _loggedInStack => [
        if (isLauchMainFromSplash)
          SlideAnimationPage(
            direction: SlideAnimationPage.bottomToTop,
            key: MainPage.valueKey,
            child: MainPage(
              authInfo: authInfo!,
              onDetail: (id) {
                storyId = id;
                notifyListeners();
              },
              onLogout: () {
                isLoggedIn = null;
                isRegister = false;
                onBoarding = false;
                authInfo = null;
                notifyListeners();
              },
            ),
          ),
        if (isLauchMainFromSplash == false)
          MaterialPage(
            key: MainPage.valueKey,
            child: MainPage(
              authInfo: authInfo!,
              onDetail: (id) {
                storyId = id;
                notifyListeners();
              },
              onLogout: () {
                isLoggedIn = null;
                isRegister = false;
                onBoarding = false;
                notifyListeners();
              },
            ),
          ),
        if (storyId != null)
          MaterialPage(
            key: DetailPage.valueKey,
            child: DetailPage(
              onNavigateBack: () {
                storyId = null;
                notifyListeners();
              },
              storyId: storyId!,
            ),
          ),
      ];
}

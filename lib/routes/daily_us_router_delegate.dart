import 'package:daily_us/presentation/pages/login_page.dart';
import 'package:daily_us/presentation/pages/main_page.dart';
import 'package:daily_us/presentation/pages/on_boarding_page.dart';
import 'package:daily_us/presentation/pages/register_page.dart';
import 'package:daily_us/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';

class DailyUsRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  DailyUsRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool onBoarding = false;
  bool isRegister = false;

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
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegister = false;
        onBoarding = true;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    /* Do Nothing */
  }

  List<Page> get _splashStack => [
        MaterialPage(
          key: const ValueKey("SplashPage"),
          child: SplashPage(
            onAnimationEnd: () {
              // check if user already logged in
              isLoggedIn = false;
              isRegister = false;
              onBoarding = true;
              notifyListeners();
            },
          ),
        ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("OnBoardingPage"),
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
            key: const ValueKey("LoginPage"),
            child: LoginPage(
              onSuccessLogin: () {
                isLoggedIn = true;
                notifyListeners();
              },
              onRegister: () {
                isRegister = true;
                notifyListeners();
              },
            ),
          ),
        if (onBoarding == false && isLoggedIn == false && isRegister == true)
          MaterialPage(
            key: const ValueKey("RegisterPage"),
            child: RegisterPage(
              onSuccessRegister: () {
                isRegister = false;
                notifyListeners();
              },
              onLogin: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("MainPage"),
          child: MainPage(
            onLogout: () {
              isLoggedIn = false;
              isRegister = false;
              onBoarding = true;
              notifyListeners();
            },
          ),
        ),
      ];
}

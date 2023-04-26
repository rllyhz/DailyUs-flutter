import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/usecases/logout.dart';
import 'package:daily_us/presentation/pages/anim/fade_animation_page.dart';
import 'package:daily_us/presentation/pages/change_language_dialog_page.dart';
import 'package:daily_us/presentation/pages/home_page.dart';
import 'package:daily_us/presentation/pages/logout_dialog_page.dart';
import 'package:daily_us/presentation/pages/post_story_page.dart';
import 'package:daily_us/presentation/pages/profile_page.dart';
import 'package:daily_us/injection.dart' as di;
import 'package:flutter/material.dart';

class MainPageRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  MainPageRouterDelegate({
    required this.onDetail,
    required this.onLogout,
    required this.onGoHome,
    required this.homePageController,
    required this.onUpdateLocalization,
    required this.authInfo,
  });

  final void Function(String) onDetail;
  final void Function() onLogout;
  final void Function() onGoHome;
  final void Function(Locale, String, String) onUpdateLocalization;
  final HomePageController homePageController;
  final AuthInfo authInfo;
  final Logout logoutUsecase = di.locator<Logout>();

  List<Locale>? _locales;
  Locale? _activeLocale;

  int _selectedPageIndex = 0;
  bool _isLastHistoryReached = true;
  bool _shouldShowLogoutConfirm = false;

  final List<int> _historyIndexes = [0];

  set selectedPageIndex(int newIndex) {
    if (_selectedPageIndex == newIndex) return;

    // cancel all dialogs
    _shouldShowLogoutConfirm = false;
    _locales = null;
    _activeLocale = null;

    if (newIndex == 0) {
      _historyIndexes.clear();
      _historyIndexes.add(0);
      _isLastHistoryReached = true;
    } else {
      _historyIndexes.add(newIndex);
      _isLastHistoryReached = false;
    }

    _selectedPageIndex = newIndex;
    notifyListeners();
  }

  int get selectedPageIndex => _selectedPageIndex;

  bool get isLastIndexReached => _isLastHistoryReached;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: [
        FadeAnimationPage(
          key: HomePage.valueKey,
          child: HomePage(
            authInfo: authInfo,
            onDetail: onDetail,
            controller: homePageController,
          ),
        ),
        if (_selectedPageIndex == 1)
          FadeAnimationPage(
            key: PostStoryPage.valueKey,
            child: PostStoryPage(
              authInfo: authInfo,
              onUploadSuccess: onGoHome,
            ),
          ),
        if (_selectedPageIndex == 2)
          FadeAnimationPage(
            key: ProfilePage.valueKey,
            child: ProfilePage(
              authInfo: authInfo,
              onShowConfirmLogout: () {
                _shouldShowLogoutConfirm = true;
                notifyListeners();
              },
              onShowLanguageChangeDialog: (supportedLocales, activeLocale) {
                _locales = supportedLocales;
                _activeLocale = activeLocale;
                notifyListeners();
              },
            ),
          ),
        if (_shouldShowLogoutConfirm)
          FadeAnimationPage(
            opaque: false,
            child: LogoutDialogPage(
              key: LogoutDialogPage.valueKey,
              onCancel: () {
                _shouldShowLogoutConfirm = false;
                notifyListeners();
              },
              onLogout: () {
                _shouldShowLogoutConfirm = false;
                notifyListeners();

                // clear auth info state
                logoutUsecase.execute();

                onLogout();
              },
            ),
          ),
        if (_locales != null && _activeLocale != null)
          FadeAnimationPage(
            opaque: false,
            child: ChangeLanguageDialogPage(
              key: ChangeLanguageDialogPage.valueKey,
              locales: _locales!,
              activeLocale: _activeLocale!,
              onUpdateLocalization: (newLocale, successMessage, failedMessage) {
                _locales = null;
                _activeLocale = null;
                notifyListeners();

                onUpdateLocalization(newLocale, successMessage, failedMessage);
              },
              onCancel: () {
                _locales = null;
                _activeLocale = null;
                notifyListeners();
              },
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (_historyIndexes.length > 1) {
          _historyIndexes.removeLast();
          _selectedPageIndex = _historyIndexes.last;

          if (_historyIndexes.length == 1) {
            // if only one index in history which is 0
            _isLastHistoryReached = true;
          }

          notifyListeners();
        }

        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async {
    // do nothing for now
  }
}

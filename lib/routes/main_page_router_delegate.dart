import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/presentation/pages/anim/fade_animation_page.dart';
import 'package:daily_us/presentation/pages/home_page.dart';
import 'package:daily_us/presentation/pages/post_story_page.dart';
import 'package:daily_us/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MainPageRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  MainPageRouterDelegate({
    required this.onDetail,
    required this.onLogout,
    required this.onGoHome,
    required this.authInfo,
  });

  final void Function(String) onDetail;
  final void Function() onLogout;
  final void Function() onGoHome;
  final AuthInfo authInfo;

  int _selectedPageIndex = 0;
  bool _isLastHistoryReached = true;

  final List<int> _historyIndexes = [0];

  set selectedPageIndex(int newIndex) {
    if (_selectedPageIndex == newIndex) return;

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
              onLogout: onLogout,
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

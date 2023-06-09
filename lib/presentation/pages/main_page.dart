import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/data/models/main_page_configuration.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/presentation/pages/home_page.dart';
import 'package:daily_us/presentation/widgets/daily_us_bottom_nav_bar.dart';
import 'package:daily_us/routes/main_page_route_information_parser.dart';
import 'package:daily_us/routes/main_page_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  static const valueKey = ValueKey("MainPage");

  const MainPage({
    super.key,
    required this.onLogout,
    required this.onDetail,
    required this.authInfo,
    required this.onUpdateLocalization,
  });

  final void Function() onLogout;
  final void Function(String) onDetail;
  final void Function(Locale, String, String) onUpdateLocalization;
  final AuthInfo authInfo;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainPageRouterDelegate _navBarRouterDelegate;
  late MainPageRouteInformationParser _navBarRouteInformationParser;
  late ChildBackButtonDispatcher _backButtonDispatcher;
  late DailyUsBottomNavBarController _bottomNavController;
  late HomePageController _homePageController;

  @override
  void initState() {
    super.initState();

    _bottomNavController = DailyUsBottomNavBarController();
    _homePageController = HomePageController();

    _navBarRouterDelegate = MainPageRouterDelegate(
      homePageController: _homePageController,
      onUpdateLocalization: widget.onUpdateLocalization,
      onSelectedIndexChanged: (selectedIndex) {
        _bottomNavController.clickItem(selectedIndex);
      },
      authInfo: widget.authInfo,
      onDetail: widget.onDetail,
      onLogout: widget.onLogout,
      onGoHome: () {
        _bottomNavController.clickItem(0);
        // should refresh after uploading
        _homePageController.refresh();
      },
    );

    _navBarRouteInformationParser = MainPageRouteInformationParser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var outerBackButtonDispatcher = Router.of(context).backButtonDispatcher;
    _backButtonDispatcher =
        outerBackButtonDispatcher!.createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    _backButtonDispatcher.takePriority();

    return Scaffold(
      bottomNavigationBar: DailyUsBottomNavBar(
        controller: _bottomNavController,
        backgroundColor: Colors.transparent,
        showLabel: false,
        onTap: (newIndex) {
          if (!_navBarRouterDelegate.canSwitchPage) return;

          setState(() {
            _navBarRouterDelegate.selectedPageIndex = newIndex;

            if (_navBarRouterDelegate.selectedPageIndex == newIndex &&
                newIndex == 0) {
              // should scroll to the top
              _homePageController.scrollToTop();
            }
          });
        },
        items: [
          DailyUsBottomNavBarItem(
            icon: SvgPicture.asset(
              _navBarRouterDelegate.selectedPageIndex == 0
                  ? 'assets/icon_home_filled.svg'
                  : 'assets/icon_home_outlined.svg',
              width: 30.0,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            label: AppLocalizations.of(context)!.titleHome,
          ),
          DailyUsBottomNavBarItem(
            icon: SvgPicture.asset(
              _navBarRouterDelegate.selectedPageIndex == 1
                  ? 'assets/icon_post_filled.svg'
                  : 'assets/icon_post_outlined.svg',
              width: 32.0,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            label: AppLocalizations.of(context)!.titlePost,
          ),
          DailyUsBottomNavBarItem(
            icon: SvgPicture.asset(
              _navBarRouterDelegate.selectedPageIndex == 2
                  ? 'assets/icon_settings_filled.svg'
                  : 'assets/icon_settings_outlined.svg',
              width: 32.0,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            label: AppLocalizations.of(context)!.titleSettings,
          ),
        ],
      ),
      body: Router<MainPageConfiguration>(
        routerDelegate: _navBarRouterDelegate,
        routeInformationParser: _navBarRouteInformationParser,
        backButtonDispatcher: _backButtonDispatcher,
      ),
    );
  }
}

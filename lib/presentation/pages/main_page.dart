import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/presentation/widgets/daily_us_bottom_nav_bar.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
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
  });

  final void Function() onLogout;
  final void Function(String) onDetail;
  final AuthInfo authInfo;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainPageRouterDelegate _navBarRouterDelegate;
  late ChildBackButtonDispatcher _backButtonDispatcher;
  late DailyUsBottomNavBarController _bottomNavController;

  @override
  void initState() {
    super.initState();

    _bottomNavController = DailyUsBottomNavBarController();

    _navBarRouterDelegate = MainPageRouterDelegate(
      authInfo: widget.authInfo,
      onDetail: widget.onDetail,
      onLogout: widget.onLogout,
      onGoHome: () {
        _bottomNavController.clickItem(0);
      },
    );
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

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: DailyUsBottomNavBar(
          controller: _bottomNavController,
          backgroundColor: Colors.transparent,
          showLabel: false,
          onTap: (newIndex) {
            setState(() {
              _navBarRouterDelegate.selectedPageIndex = newIndex;
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
        body: Router(
          routerDelegate: _navBarRouterDelegate,
          backButtonDispatcher: _backButtonDispatcher,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.dialogTitleQuitConfirm,
          style: titleTextStyle(),
        ),
        content: Text(
          AppLocalizations.of(context)!.dialogMessageQuitConfirm,
          style: homeCardDescriptionTextStyle(
            fontSize: 14.0,
          ),
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              AppLocalizations.of(context)!.dialogNegativeActionQuitConfirm,
              style: homeCardDescriptionTextStyle(fontSize: 14.0),
            ),
          ),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              AppLocalizations.of(context)!.dialogPositiveActionQuitConfirm,
              style: homeCardDescriptionTextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    ));
  }
}

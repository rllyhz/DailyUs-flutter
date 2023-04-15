import 'package:daily_us/routes/main_page_router_delegate.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const valueKey = ValueKey("MainPage");

  const MainPage({
    super.key,
    required this.onLogout,
    required this.onDetail,
  });

  final void Function() onLogout;
  final void Function(String) onDetail;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainPageRouterDelegate _navBarRouterDelegate;
  late ChildBackButtonDispatcher _backButtonDispatcher;

  @override
  void initState() {
    super.initState();

    _navBarRouterDelegate = MainPageRouterDelegate(
      widget.onDetail,
      widget.onLogout,
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
        bottomNavigationBar: BottomNavigationBar(
          onTap: (newIndex) {
            setState(() {
              _navBarRouterDelegate.selectedPageIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "PostStory",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.verified_user),
              label: "Profile",
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
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit the app.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    ));
  }
}

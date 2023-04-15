import 'package:daily_us/presentation/pages/home_page.dart';
import 'package:daily_us/presentation/pages/post_story_page.dart';
import 'package:daily_us/presentation/pages/profile_page.dart';
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
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (newIndex) {
          setState(() => _selectedPageIndex = newIndex);
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
      body: Center(
        child: _createSelectedPage(
          _selectedPageIndex,
          widget.onLogout,
          widget.onDetail,
        ),
      ),
    );
  }

  Widget _createSelectedPage(
    int index,
    void Function() onLogout,
    void Function(String) onDetail,
  ) {
    if (index == 1) {
      return const PostStoryPage();
    } else if (index == 2) {
      return ProfilePage(
        onLogout: onLogout,
      );
    } else {
      return HomePage(
        onDetail: onDetail,
      );
    }
  }
}

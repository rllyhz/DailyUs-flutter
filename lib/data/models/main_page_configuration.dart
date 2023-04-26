class MainPageConfiguration {
  final bool home;
  final bool post;
  final bool profile;

  MainPageConfiguration.home()
      : home = true,
        post = false,
        profile = false;

  MainPageConfiguration.post()
      : home = false,
        post = true,
        profile = false;

  MainPageConfiguration.profile()
      : home = false,
        post = false,
        profile = true;

  bool get isHome => home == true && post == false && profile == false;
  bool get isPost => home == false && post == true && profile == false;
  bool get isProfile => home == false && post == false && profile == true;
}

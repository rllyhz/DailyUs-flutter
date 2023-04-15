class PageConfiguration {
  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? storyId;

  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null,
        storyId = null;

  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false,
        storyId = null;

  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false,
        storyId = null;

  PageConfiguration.main()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = null;

  PageConfiguration.detail(String this.storyId)
      : unknown = false,
        register = false,
        loggedIn = true;

  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null,
        storyId = null;

  bool get isSplashPage =>
      unknown == false &&
      register == false &&
      loggedIn == null &&
      storyId == null;

  bool get isLoginPage =>
      unknown == false &&
      register == false &&
      loggedIn == false &&
      storyId == null;

  bool get isRegisterPage =>
      unknown == false &&
      register == true &&
      loggedIn == false &&
      storyId == null;

  bool get isMainPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storyId == null;

  bool get isDetailPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storyId != null;

  bool get isUnknownPage =>
      unknown == true &&
      register == false &&
      loggedIn == null &&
      storyId == null;
}

class PageConfiguration {
  final bool unknown;
  final bool onBoarding;
  final bool register;
  final bool? loggedIn;
  final String? storyId;

  PageConfiguration.splash()
      : unknown = false,
        onBoarding = false,
        register = false,
        loggedIn = null,
        storyId = null;

  PageConfiguration.onBoarding()
      : unknown = false,
        onBoarding = true,
        register = false,
        loggedIn = null,
        storyId = null;

  PageConfiguration.login()
      : unknown = false,
        onBoarding = false,
        register = false,
        loggedIn = false,
        storyId = null;

  PageConfiguration.register()
      : unknown = false,
        onBoarding = false,
        register = true,
        loggedIn = false,
        storyId = null;

  PageConfiguration.main()
      : unknown = false,
        onBoarding = false,
        register = false,
        loggedIn = true,
        storyId = null;

  PageConfiguration.detail(String this.storyId)
      : unknown = false,
        onBoarding = false,
        register = false,
        loggedIn = true;

  PageConfiguration.unknown()
      : unknown = true,
        onBoarding = false,
        register = false,
        loggedIn = null,
        storyId = null;

  bool get isSplashPage =>
      unknown == false &&
      onBoarding == false &&
      register == false &&
      loggedIn == null &&
      storyId == null;

  bool get isOnBoardingPage =>
      unknown == false &&
      onBoarding == true &&
      register == false &&
      loggedIn == null &&
      storyId == null;

  bool get isLoginPage =>
      unknown == false &&
      register == false &&
      loggedIn == false &&
      onBoarding == false &&
      storyId == null;

  bool get isRegisterPage =>
      unknown == false &&
      register == true &&
      loggedIn == false &&
      onBoarding == false &&
      storyId == null;

  bool get isMainPage =>
      unknown == false &&
      onBoarding == false &&
      register == false &&
      loggedIn == true &&
      storyId == null;

  bool get isDetailPage =>
      unknown == false &&
      onBoarding == false &&
      register == false &&
      loggedIn == true &&
      storyId != null;

  bool get isUnknownPage =>
      unknown == true &&
      onBoarding == false &&
      register == false &&
      loggedIn == null &&
      storyId == null;
}

class PageConfiguration {
  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null;

  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false;

  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false;

  PageConfiguration.home()
      : unknown = false,
        register = false,
        loggedIn = true;

  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null;

  final bool unknown;
  final bool register;
  final bool? loggedIn;

  bool get isSplashPage =>
      unknown == false && register == false && loggedIn == null;

  bool get isLoginPage =>
      unknown == false && register == false && loggedIn == false;

  bool get isRegisterPage =>
      unknown == false && register == true && loggedIn == false;

  bool get isHomePage =>
      unknown == false && register == false && loggedIn == true;

  bool get isUnknownPage =>
      unknown == true && register == false && loggedIn == null;
}

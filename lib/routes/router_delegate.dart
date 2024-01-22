import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/repositories/auth_repository.dart';
import 'package:flutter_intermediate_story_app/routes/page_configuration.dart';
import 'package:flutter_intermediate_story_app/screen/login_screen.dart';
import 'package:flutter_intermediate_story_app/screen/splash_screen.dart';
import 'package:flutter_intermediate_story_app/screen/home_screen.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  MyRouterDelegate(this.authRepository)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  bool? isUnknown;
  String? selectedStory;

  Future<void> _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    if (kDebugMode) {
      log('cek isLoggedIn : $isLoggedIn');
    }
    notifyListeners();
  }

  List<Page> get _splashStack => const [
        MaterialPage(key: ValueKey("SplashPage"), child: SplashScreen()),
      ];

  List<Page> get _loggedOutStack => [
        const MaterialPage(key: ValueKey("LoginPage"), child: LoginScreen()),
      ];

  List<Page> get _loggedInStack => [
        const MaterialPage(key: ValueKey("HomePage"), child: HomeScreen()),
      ];

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);

        if (!didPop) {
          return false;
        }

        isRegister = false;
        selectedStory = null;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    if (configuration.isUnknownPage) {
      isUnknown = true;
      isRegister = false;
    } else if (configuration.isRegisterPage) {
      isRegister = true;
    } else if (configuration.isHomePage ||
        configuration.isLoginPage ||
        configuration.isSplashPage) {
      isUnknown = false;
      isRegister = false;
    } else {
      if (kDebugMode) {
        log('Could not set new route');
      }
    }
    notifyListeners();
  }

  @override
  PageConfiguration? get currentConfiguration {
    if (isLoggedIn == null) {
      return PageConfiguration.splash();
    } else if (isRegister == true) {
      return PageConfiguration.register();
    } else if (isLoggedIn == false) {
      return PageConfiguration.login();
    } else if (isUnknown == true) {
      return PageConfiguration.unknown();
    } else if (selectedStory == null) {
      return PageConfiguration.home();
    } else {
      return null;
    }
  }
}

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/repositories/auth_repository.dart';
import 'package:flutter_intermediate_story_app/routes/page_configuration.dart';
import 'package:flutter_intermediate_story_app/screen/home_screen.dart';
import 'package:flutter_intermediate_story_app/screen/login_screen.dart';
import 'package:flutter_intermediate_story_app/screen/map_screen.dart';
import 'package:flutter_intermediate_story_app/screen/register_screen.dart';
import 'package:flutter_intermediate_story_app/screen/splash_screen.dart';
import 'package:flutter_intermediate_story_app/screen/stories_add_screen.dart';
import 'package:flutter_intermediate_story_app/screen/stories_detail_screen.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  MyRouterDelegate(this.authRepository)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  bool? isUnknown;
  String? selectedStory;
  bool? isAddStory;
  bool? isMap;
  double? latitudeStory;
  double? longitudeStory;

  Future<void> _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }

  List<Page> get _splashStack => const [
        MaterialPage(key: ValueKey('SplashPage'), child: SplashScreen()),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey('LoginPage'),
          child: LoginScreen(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister)
          MaterialPage(
            key: const ValueKey('RegisterPage'),
            child: RegisterScreen(
              onRegister: () {
                isRegister = false;
                notifyListeners();
              },
              onLogin: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey('HomePage'),
          child: HomeScreen(
            onLogout: () {
              isLoggedIn = false;
              notifyListeners();
            },
            onStoryDetail: (String storyId) {
              selectedStory = storyId;
              notifyListeners();
            },
            onAddStory: () async {
              isAddStory = true;
              notifyListeners();
            },
          ),
        ),
        if (selectedStory != null)
          MaterialPage(
            key: const ValueKey('StoriesDetailPage'),
            child: StoriesDetailScreen(
              storyId: '$selectedStory',
              onOpenMap: (latitude, longitude) {
                isMap = true;
                latitudeStory = latitude;
                longitudeStory = longitude;
                notifyListeners();
              },
            ),
          ),
        if (isMap == true)
          MaterialPage(
            key: const ValueKey('MapPage'),
            child:
                MapScreen(latitude: latitudeStory, longitude: longitudeStory),
          ),
        if (isAddStory == true)
          MaterialPage(
            key: const ValueKey('AddStoryPage'),
            child: StoriesAddScreen(
              onUpload: () {
                isAddStory = null;
                notifyListeners();
              },
            ),
          ),
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
        isAddStory = null;
        isMap = null;
        latitudeStory = null;
        longitudeStory = null;
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
      selectedStory = null;
      isAddStory = null;
      isMap = null;
      isRegister = false;
    } else if (configuration.isStoriesDetailPage) {
      isUnknown = false;
      isRegister = false;
      isMap = null;
      isAddStory = null;
      selectedStory = configuration.storyId.toString();
    } else if (configuration.isAddStoryPage) {
      isUnknown = false;
      isRegister = false;
      selectedStory = null;
      isMap = null;
      isAddStory = true;
    } else if (configuration.isMapPage) {
      isUnknown = false;
      isRegister = false;
      selectedStory = null;
      isAddStory = null;
      isMap = true;
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
    } else if (selectedStory != null) {
      return PageConfiguration.storiesDetail(selectedStory!);
    } else if (isAddStory == true) {
      return PageConfiguration.addStory();
    } else {
      return null;
    }
  }
}

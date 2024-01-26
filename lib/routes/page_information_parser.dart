import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/routes/page_configuration.dart';

class MyRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = Uri.parse(routeInformation.uri.path);
    if (uri.pathSegments.isEmpty) {
      return PageConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      final pathSegmentFirst = uri.pathSegments[0].toLowerCase();
      if (pathSegmentFirst == 'splash') {
        return PageConfiguration.splash();
      } else if (pathSegmentFirst == 'login') {
        return PageConfiguration.login();
      } else if (pathSegmentFirst == 'register') {
        return PageConfiguration.register();
      } else if (pathSegmentFirst == 'home') {
        return PageConfiguration.home();
      } else {
        return PageConfiguration.unknown();
      }
    } else {
      return PageConfiguration.unknown();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    if (configuration.isUnknownPage) {
      return RouteInformation(uri: Uri.parse('/unknown'));
    } else if (configuration.isSplashPage) {
      return RouteInformation(uri: Uri.parse('/splash'));
    } else if (configuration.isRegisterPage) {
      return RouteInformation(uri: Uri.parse('/register'));
    } else if (configuration.isLoginPage) {
      return RouteInformation(uri: Uri.parse('/login'));
    } else if (configuration.isHomePage) {
      return RouteInformation(uri: Uri.parse('/'));
    } else {
      return null;
    }
  }
}

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
      } else if (pathSegmentFirst == 'stories-add') {
        return PageConfiguration.addStory();
      } else if (pathSegmentFirst == 'map') {
        return PageConfiguration.map();
      } else if (pathSegmentFirst == 'location') {
        return PageConfiguration.location();
      } else {
        return PageConfiguration.unknown();
      }
    } else if (uri.pathSegments.length == 2) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      if (first == 'stories-detail') {
        return PageConfiguration.storiesDetail(second);
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
    } else if (configuration.isStoriesDetailPage) {
      return RouteInformation(
        uri: Uri.parse('/stories-detail/${configuration.storyId}'),
      );
    } else if (configuration.isMapPage) {
      return RouteInformation(uri: Uri.parse('/map'));
    } else if (configuration.isAddStoryPage) {
      return RouteInformation(uri: Uri.parse('/stories-add'));
    } else if (configuration.isLocationPage) {
      return RouteInformation(uri: Uri.parse('/location'));
    } else {
      return null;
    }
  }
}

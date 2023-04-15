import 'package:daily_us/data/models/page_configuration.dart';
import 'package:flutter/material.dart'
    show RouteInformation, RouteInformationParser;

class DailyUsRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location.toString());

    if (uri.pathSegments.isEmpty) {
      // => "/"
      return PageConfiguration.main();
    } else if (uri.pathSegments.length == 1) {
      // path parameter => "/aaa"
      final first = uri.pathSegments[0].toLowerCase();
      if (first == 'login') {
        return PageConfiguration.login();
      } else if (first == 'register') {
        return PageConfiguration.register();
      } else if (first == 'splash') {
        return PageConfiguration.splash();
      } else {
        return PageConfiguration.unknown();
      }
    } else if (uri.pathSegments.length == 3) {
      // path parameter => "/story/id"
      final first = uri.pathSegments[0].toLowerCase();
      final storyId = uri.pathSegments[1].toLowerCase();
      if (first == 'story' && storyId.isNotEmpty) {
        return PageConfiguration.detail(storyId);
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
      return const RouteInformation(location: '/unknown');
    } else if (configuration.isSplashPage) {
      return const RouteInformation(location: '/splash');
    } else if (configuration.isRegisterPage) {
      return const RouteInformation(location: '/register');
    } else if (configuration.isLoginPage) {
      return const RouteInformation(location: '/login');
    } else if (configuration.isMainPage) {
      return const RouteInformation(location: '/');
    } else if (configuration.isDetailPage) {
      return RouteInformation(location: "/story/${configuration.storyId}");
    } else {
      return null;
    }
  }
}

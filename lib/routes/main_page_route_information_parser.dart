import 'package:daily_us/data/models/main_page_configuration.dart';
import 'package:flutter/material.dart'
    show RouteInformation, RouteInformationParser, debugPrint;

class MainPageRouteInformationParser
    extends RouteInformationParser<MainPageConfiguration> {
  @override
  Future<MainPageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    // Idk why this method is not getting invoked
    final uri = Uri.parse(routeInformation.location.toString());
    debugPrint(uri.pathSegments.toString());
    if (uri.pathSegments.isEmpty) {
      // => "/"
      return MainPageConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      // => "/something"
      final path = uri.pathSegments[0].toLowerCase();
      if (path == 'post') {
        return MainPageConfiguration.post();
      } else if (path == 'profile') {
        return MainPageConfiguration.profile();
      }
    }

    // else - just return to the outer router delegate
    return super.parseRouteInformation(routeInformation);
  }

  @override
  RouteInformation? restoreRouteInformation(
      MainPageConfiguration configuration) {
    if (configuration.isHome) {
      debugPrint('url home');
      return const RouteInformation(location: '/');
    } else if (configuration.isPost) {
      debugPrint('url post');
      return const RouteInformation(location: '/post');
    } else if (configuration.isProfile) {
      debugPrint('url profile');
      return const RouteInformation(location: '/profile');
    } else {
      return null;
    }
  }
}

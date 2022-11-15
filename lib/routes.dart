import 'package:nexusapp/routes/home.dart';
import 'package:nexusapp/routes/box_view.dart';
import 'package:nexusapp/routes/login.dart';
import 'package:nexusapp/routes/signup.dart';
import 'package:nexusapp/routes/add_activity.dart';
import 'package:nexusapp/routes/infopage.dart';

import 'package:flutter/material.dart';

/// Route management class that handles the navigation among various pages of the
/// app. New routes should be opened in the following ways:
///
/// ```dart
/// Navigator.of(context).pushNamed(RouteGenerator.home);
/// Navigator.pushNamed(context, RouteGenerator.home);
/// ```
///
abstract class RouteGenerator {
  static const root = '/';
  static const home = '/home';
  static const boxView = '/box_view';
  static const login = '/login';
  static const signup = '/signup';
  static const addActivity = '/add_activity';
  static const infoPage = '/infopage';

  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return PageRouteBuilder<Home>(
          settings: settings,
          pageBuilder: (_, __, ___) => Login(),
        );
      case home:
        return PageRouteBuilder<Home>(
          settings: settings,
          pageBuilder: (_, __, ___) => const Home(),
        );

      case boxView:
        return PageRouteBuilder<ListView>(
          settings: settings,
          pageBuilder: (_, __, ___) => const BoxView(),
        );

      case login:
        return PageRouteBuilder<ListView>(
          settings: settings,
          pageBuilder: (_, __, ___) => Login(),
        );

      case signup:
        return PageRouteBuilder<ListView>(
          settings: settings,
          pageBuilder: (_, __, ___) => Signup(),
        );

      case addActivity:
        return PageRouteBuilder<ListView>(
          settings: settings,
          pageBuilder: (_, __, ___) => AddActivity(),
        );

      case infoPage:
        return PageRouteBuilder<ListView>(
          settings: settings,
          pageBuilder: (_, __, ___) => InfoPage(),
        );

      default:
        throw const RouteException('Route not found');
    }
  }
}

class RouteException implements Exception {
  final String message;

  const RouteException(this.message);
}

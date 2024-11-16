import 'package:detectionApp/features/dashboard/dashboard_screen.dart';
import 'package:detectionApp/features/main/main_screen.dart';
import 'package:flutter/material.dart';

import 'features/auth/views/login.dart';
import 'features/detection/views/views.dart';
import 'features/profile/views/views.dart';
import 'features/settings/views/views.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case LoginScreen.routeName:
    //   return _getPageRoute(
    //       routeName: settings.name!,
    //       viewToShow: const LoginScreen(),
    //       useDefaultPageRoute: true);
    // case SignUpScreen.routeName:
    //   return _getPageRoute(
    //       routeName: settings.name!,
    //       viewToShow: const SignUpScreen(),
    //       useDefaultPageRoute: true);
    case InitDetectionPage.routeName:
      return _getPageRoute(
          routeName: settings.name!,
          viewToShow: const InitDetectionPage(),
          useDefaultPageRoute: true);
    case SettingsPage.routeName:
      return _getPageRoute(
          routeName: settings.name!,
          viewToShow: const SettingsPage(),
          useDefaultPageRoute: true);
    case ProfilePage.routeName:
      return _getPageRoute(
          routeName: settings.name!,
          viewToShow: const ProfilePage(),
          useDefaultPageRoute: true);
    case DashboardScreen.routeName:
      return _getPageRoute(
          routeName: settings.name!,
          viewToShow: const DashboardScreen(),
          useDefaultPageRoute: true);
    case ResultPage.routeName:
      return _getPageRoute(
          routeName: settings.name!,
          viewToShow: ResultPage(
            arguments: settings.arguments as ResultPageArguments,
          ),
          useDefaultPageRoute: true);
    case LoginPage.routeName:
      return _getPageRoute(
          routeName: settings.name!,
          viewToShow: const LoginPage(),
          useDefaultPageRoute: true);
    case MainScreen.routeName:
      return _getPageRoute(
          routeName: settings.name!,
          viewToShow: MainScreen(),
          useDefaultPageRoute: true);

    default:
      return noRouteDefinedPage(settings);
  }
}

MaterialPageRoute noRouteDefinedPage(RouteSettings settings) {
  return MaterialPageRoute(
      builder: (_) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
            ),
            body: Center(child: Text('No route defined for ${settings.name}')),
          ));
}

PageRoute _getPageRoute({
  required String routeName,
  required Widget viewToShow,
  bool useDefaultPageRoute = false,
  bool? fullScreenDialog = false,
}) {
  if (useDefaultPageRoute) {
    return MaterialPageRoute(
      builder: (context) => viewToShow,
      settings: RouteSettings(
        name: routeName,
      ),
      fullscreenDialog: fullScreenDialog ?? false,
    );
  }
  return MaterialPageRoute(
    builder: (context) => viewToShow,
    settings: RouteSettings(name: routeName),
    fullscreenDialog: fullScreenDialog ?? false,
  );
}

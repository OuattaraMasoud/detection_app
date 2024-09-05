import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop<T extends Object?>([T? result]) {
    return _navigationKey.currentState != null &&
            _navigationKey.currentState!.canPop()
        ? _navigationKey.currentState?.pop(result)
        : null;
  }

  void popUntil(String routeName) {
    return _navigationKey.currentState
        ?.popUntil(ModalRoute.withName(routeName));
  }

  Future<dynamic>? navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? replaceWith(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? pushNamedAndRemoveUntil(String routeName,
      {dynamic arguments}) {
    return _navigationKey.currentState?.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }
}

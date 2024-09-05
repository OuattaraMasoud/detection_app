import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../enum_to_string.dart';
import '../utils.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;
  static const String themeModeKey = 'themeMode';
  static const String debugModeKey = 'debugModeKey';

  static const String firstLaunchSetupDoneKey = 'firstLaunchSetupDone';

  static const String shoppyUserAuthDataKey = 'shoppyUserAuthData';
  static const String apiBaseUrlKey = 'apiBaseUrl';
  static const String shoppyApiKey = 'shoppyApiKey';

  static const String showOnboardingPagesKey = 'showOnboardingPages';
  static const String privacyPolicyUrlKey = 'privacyPolicyUrl';

  //Theme Mode
  ThemeMode get themeMode => _getThemeModeFromDisk(themeModeKey);
  set themeMode(ThemeMode value) => _saveThemeModeToDisk(themeModeKey, value);

  static Future<LocalStorageService> getInstance() async {
    _instance ??= LocalStorageService();

    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  String get apiBaseUrl => 'https://066e-102-180-187-59.ngrok-free.app/';

  // Initial/First launch setup done
  bool get firstLaunchSetupDone =>
      _getFromDisk(firstLaunchSetupDoneKey) ?? false;
  set firstLaunchSetupDone(bool value) =>
      _saveToDisk(firstLaunchSetupDoneKey, value);
  // Show onboarding pages
  bool get showOnboardingPages => _getFromDisk(showOnboardingPagesKey) ?? true;
  set showOnboardingPages(bool value) =>
      _saveToDisk(showOnboardingPagesKey, value);

  // Enable Kontact debug mode
  bool get debugMode => _getFromDisk(debugModeKey) ?? false;
  set debugMode(bool value) => _saveToDisk(debugModeKey, value);

  // Authenticated user data
  // Authenticated user data
  String? get shoppyUserAuthData => _getFromDisk(shoppyUserAuthDataKey);
  set shoppyAuthData(String? shoppyAuthData) =>
      _saveToDisk(shoppyUserAuthDataKey, shoppyAuthData);
  Future<void> logOut() async {
    await _preferences!.remove(shoppyUserAuthDataKey);
  }

  Future<void> resetSettings() async {
    await _preferences!.clear();
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    logger.v('LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  ThemeMode _getThemeModeFromDisk(String key) {
    var value = _preferences!.getString(key);
    logger.v(
        'LocalStorageService:_getThemeModeFromDisk. key: $key value: $value');
    return value != null
        ? EnumToString.fromString(ThemeMode.values, value) ?? ThemeMode.system
        : ThemeMode.system;
  }

  void _saveThemeModeToDisk(String key, ThemeMode themeMode) {
    _preferences!.setString(key, EnumToString.convertToString(themeMode));
  }
  // List<String>? _getStringListFromDisk(String key) {
  //   var value = _preferences!.getStringList(key);
  //   logger.v('LocalStorageService:_getFromDisk. key: $key value: $value');
  //   return value;
  // }

  void _saveToDisk<T>(String key, T content) {
    logger.v(
        '(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }
}

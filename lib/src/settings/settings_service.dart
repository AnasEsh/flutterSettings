import 'package:flutter/material.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  static const String themeKey = "theme",localeKey="prefLocale";

  late SharedPreferences preferences;

  Future<void> init() async{
    preferences=await SharedPreferences.getInstance();
    locale=preferences.getString(localeKey)??"en";
    await registerLocalization(locale);
    int? themeIndex=preferences.getInt(themeKey);
    theme=ThemeMode.values[themeIndex??0];
  }

  late String _locale;
  late ThemeMode _theme;

  ThemeMode get theme => _theme;

  set theme(ThemeMode value) {
    _theme = value;
    preferences.setInt(themeKey, theme.index);
  }

  String get locale => _locale;

  set locale(String value) {
    _locale = value;
    preferences.setString(localeKey, locale);
  }

}

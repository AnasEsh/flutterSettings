import 'package:flutter/material.dart';
import 'package:restore_config/src/settings/settings_view.dart';
import 'package:restore_config/src/views/auth/Login.dart';
import 'package:restore_config/src/views/home/homeView.dart';

class AppRouter {
  static final routes = {
    LoginView.routeName: () => const LoginView(),
    HomeView.routeName: () => const HomeView(),
    SettingsView.routeName: () => const SettingsView()
  };
  static late BuildContext context;
  // static public
  static Route<dynamic> onGenerate(RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        AppRouter.context = context;
        return routes[routeSettings.name]!();
      },
    );
  }
}

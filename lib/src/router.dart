import 'package:flutter/material.dart';
import 'package:restore_config/src/views/auth/Login.dart';

class AppRouter {
  static Route<dynamic> onGenerate(RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        return LoginView();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/views/auth/Login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:restore_config/src/views/auth/home/homne.dart';

class AppRouter {
  static final routes = {"/login": () => LoginView(), "/": () => HomeView()};
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

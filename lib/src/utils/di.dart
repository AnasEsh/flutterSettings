import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restore_config/src/services/userService.dart';
import 'package:restore_config/src/utils/http/tdio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final dependincies = GetIt.instance;

Future registerLocalization(String locale) async {
  dependincies
      .registerSingleton(await AppLocalizations.delegate.load(Locale(locale)));
}

Future<void> injectDependencies() async {
  dependincies.allowReassignment = true;

  dependincies.registerSingleton(await SharedPreferences.getInstance());

  dependincies.registerSingleton<Dio>(TDio(client: Dio()).client);

  //Functional services
  dependincies.registerSingleton(UserService());
}

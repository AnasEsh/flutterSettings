import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restore_config/src/services/userService.dart';
import 'package:restore_config/src/utils/tdio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dependincies = GetIt.instance;

Future injectDependencies() async {
  dependincies.registerSingletonAsync(
      () async => await SharedPreferences.getInstance());

  dependincies.registerSingleton<Dio>(TDio(client: Dio()).client);

  //Functional services
  dependincies.registerSingleton(UserService());
}

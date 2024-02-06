import 'package:dio/dio.dart';
import 'package:restore_config/src/models/user.dart';
import 'package:restore_config/src/services/contracts/base.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/utils/helperModels/apiResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserServiceContract extends BaseService {
  @override
  Dio http = dependincies.get<Dio>();
  SharedPreferences localStorage = dependincies.get<SharedPreferences>();
  Future<ApiResult<User>> login(String email, String pswd);

  Future<User?> refreshToken();

  void saveToken(String userId);

  void removeToken();

  void logout();

  Future<ApiResult<dynamic>> register(String name, String email, String pswd);
}

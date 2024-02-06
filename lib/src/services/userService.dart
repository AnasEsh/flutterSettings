
import 'package:dio/dio.dart';
import 'package:restore_config/src/constants/requestConstants.dart';
import 'package:restore_config/src/models/user.dart';
import 'package:restore_config/src/services/base.dart';
import 'package:restore_config/src/utils/Extensions/exceptionExt.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/utils/helperModels/apiResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends BaseService {
  Dio http = dependincies.get<Dio>();
  SharedPreferences localStorage = dependincies.get<SharedPreferences>();
  Future<ApiResult<User>> login(String email, String pswd) async {
    Response<List?> r;
    try {
      r = await http.get<List?>("user?email=$email&pswd=$pswd");
    } on Exception catch (e) {
      return ApiResult(success: false, message: e.friendlyException());
    }

    final unparsed = (r.data)?.firstOrNull;

    if (unparsed != null) {
      saveToken(unparsed["id"]);
      return ApiResult(result: User.fromJson(unparsed));
    }
    return ApiResult(success: r.statusCode == 200, message: r.statusMessage);
    // return unparsed == null ? unparsed : User.fromJson(unparsed);
  }

  Future<User?> refreshToken() async {
    try {
      final uid = localStorage.getString(tokenKey);
      if (uid == null) return null;
      final r = await http.get<List?>("user?id=$uid");
      if (r.data?.isEmpty ?? true) return null;
      final userJson = r.data!.first as Map<String, dynamic>;
      return r.data == null ? null : User.fromJson(userJson);
    } catch (ex) {
      print(ex);
    }
    return null;
  }

  void saveToken(String userId) {
    localStorage.setString(tokenKey, userId);
  }

  void removeToken() {
    localStorage.remove(tokenKey);
  }

  void logout() {
    removeToken();
  }

  Future<ApiResult<dynamic>> register(
      String name, String email, String pswd) async {
    Response r;
    try {
      r = await http
          .post("user", data: {"name": name, "email": email, "pswd": pswd});
    } on Exception catch (ex) {
      return ApiResult(success: false, message: ex.friendlyException());
    }

    return ApiResult(result: r.data);
  }
}

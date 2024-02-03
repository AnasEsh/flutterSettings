import 'dart:convert';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:restore_config/src/models/user.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/utils/helperModels/apiResult.dart';

class UserService extends BaseService {
  Dio http = dependincies.get<Dio>();

  Future<ApiResult<User>> login(String email, String pswd) async {
    Response r = await http.get("user?email=$email&pswd=$pswd");
    final unparsed = (r.data as List<Map<String, dynamic>>?)?.firstOrNull;

    if (unparsed != null) {
      return ApiResult(result: User.fromJson(unparsed));
    }
    return ApiResult(success: r.statusCode == 200, message: r.statusMessage);
    // return unparsed == null ? unparsed : User.fromJson(unparsed);
  }
}

abstract class BaseService {
  AppLocalizations get localization => dependincies.get<AppLocalizations>();
}

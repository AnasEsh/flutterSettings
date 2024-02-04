import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:restore_config/src/models/user.dart';
import 'package:restore_config/src/services/base.dart';
import 'package:restore_config/src/utils/Extensions/exceptionExt.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/utils/helperModels/apiResult.dart';

class UserService extends BaseService {
  Dio http = dependincies.get<Dio>();

  Future<ApiResult<User>> login(String email, String pswd) async {
    Response<List?> r;
    try {
      r = await http.get<List?>("user?email=$email&pswd=$pswd");
    } on Exception catch (e) {
      return ApiResult(success: false, message: e.friendlyException());
    }

    final unparsed = (r.data)?.firstOrNull;

    if (unparsed != null) {
      return ApiResult(result: User.fromJson(unparsed));
    }
    return ApiResult(success: r.statusCode == 200, message: r.statusMessage);
    // return unparsed == null ? unparsed : User.fromJson(unparsed);
  }

  Future<ApiResult<dynamic>> register(
      String name, String email, String pswd) async {
    Response r;
    try {
      r = await http.post("user", data: {name: name, email: email, pswd: pswd});
    } on Exception catch (ex) {
      return ApiResult(success: false, message: ex.friendlyException());
    }

    return ApiResult(result: r.data);
  }
}

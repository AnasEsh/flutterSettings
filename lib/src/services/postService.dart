import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:restore_config/src/models/user.dart';
import 'package:restore_config/src/services/base.dart';
import 'package:restore_config/src/services/userService.dart';
import 'package:restore_config/src/utils/Extensions/exceptionExt.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/utils/helperModels/apiResult.dart';

class PostService extends BaseService {
  Dio http = dependincies.get<Dio>();
  Future getAll() async {
    try {
      final result = ApiResult();
      final r = await http.get<List?>("post");
      result.success = r.statusCode == 200;
      if (!result.success) {
        result.message = "Failed to reach server";
        return result;
      }
    } on Exception catch (ex) {
      return ApiResult(success: false, message: ex.friendlyException());
    }
  }
}

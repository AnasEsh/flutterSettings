import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restore_config/src/models/post.dart';
import 'package:restore_config/src/services/base.dart';
import 'package:restore_config/src/utils/Extensions/exceptionExt.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/utils/helperModels/apiResult.dart';

class PostService extends BaseService {
  static const apiPath = "post";
  Dio http = dependincies.get<Dio>();

  Future<ApiResult<List<Post>>> getAll() => RiskyOperation(_getAll).execute();
  Future<ApiResult<Post?>> create(Post post) => RiskyOperation(()async=>_create(post)).execute();
  
  Future<ApiResult<List<Post>>> _getAll() async {
    final ApiResult<List<Post>> result = ApiResult();
    final r = await http.get<List?>(apiPath);
    result.success = r.statusCode == 200;

    if (!result.success) {
      result.message = "Failed to reach server";
      return result;
    }
    result.result =
        (r.data ?? []).map((postJson) => Post.fromJson(postJson)).toList();

    return result;
  }

  Future<ApiResult<Post?>> _create(Post post) async {
    final r = await http.post(apiPath, data: post.toJson());
    if (r.statusCode == 201) return ApiResult(result: Post.fromJson(r.data));
    return ApiResult(success: false);
  }
}

class RiskyOperation<T> {
  Future<ApiResult<T>> Function() _op;
  Future<ApiResult<T>> execute() async {
    try {
      final result = await _op();
      return result;
    } on Exception catch (ex) {
      return ApiResult(success: false, message: ex.friendlyException());
    } on Object catch (unk) {
      return ApiResult(
          success: false,
          message: "Unknown error type occured! ->${unk.runtimeType}");
    }
  }

  RiskyOperation(this._op);
}

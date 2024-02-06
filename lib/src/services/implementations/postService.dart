import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restore_config/src/models/post.dart';
import 'package:restore_config/src/services/contracts/apiCallsWrapper.dart';
import 'package:restore_config/src/services/contracts/base.dart';
import 'package:restore_config/src/services/contracts/postServiceContract.dart';
import 'package:restore_config/src/utils/Extensions/exceptionExt.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/utils/helperModels/apiResult.dart';

class PostService extends PostServiceContract {
  @override
  Future<ApiResult<bool>> deleteImpl(Post post) async {
    final r = await http.delete("post?id=${post.id}");
    return ApiResult(result: r.statusCode == 200, success: r.statusCode == 200);
  }

  @override
  Future<ApiResult<List<Post>>> getAllImpl() async {
    final ApiResult<List<Post>> result = ApiResult();
    final r = await http.get<List?>(PostServiceContract.apiPath);
    result.success = r.statusCode == 200;

    if (!result.success) {
      result.message = "Failed to reach server";
      return result;
    }
    result.result =
        (r.data ?? []).map((postJson) => Post.fromJson(postJson)).toList();

    return result;
  }

  @override
  Future<ApiResult<Post?>> createImpl(Post post) async {
    final r = await http.post(PostServiceContract.apiPath, data: post.toJson());
    if (r.statusCode == 201) return ApiResult(result: Post.fromJson(r.data));
    return ApiResult(success: false);
  }
}

import 'package:restore_config/src/models/post.dart';
import 'package:restore_config/src/services/contracts/apiCallsWrapper.dart';
import 'package:restore_config/src/services/contracts/base.dart';
import 'package:restore_config/src/utils/helperModels/apiResult.dart';

abstract class PostServiceContract extends BaseService {
  static const apiPath = "post";

  Future<ApiResult<List<Post>>> getAll() =>
      RiskyOperation(getAllImpl).execute();
  Future<ApiResult<Post?>> create(Post post) =>
      RiskyOperation(() async => createImpl(post)).execute();
  Future<ApiResult<bool>> delete(Post post) =>
      RiskyOperation(() async => await deleteImpl(post)).execute();

  Future<ApiResult<bool>> deleteImpl(Post post);

  Future<ApiResult<List<Post>>> getAllImpl();

  Future<ApiResult<Post?>> createImpl(Post post);
}

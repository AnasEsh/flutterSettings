import 'package:restore_config/src/utils/Extensions/exceptionExt.dart';
import 'package:restore_config/src/utils/helperModels/apiResult.dart';

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

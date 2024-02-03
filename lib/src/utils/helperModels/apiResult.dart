class ApiResult<T> {
  bool success;
  T? result;
  String? message;
  ApiResult({this.success = true, this.result, this.message});
}

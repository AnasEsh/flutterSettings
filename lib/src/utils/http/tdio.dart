import 'package:dio/dio.dart';
import 'package:restore_config/src/constants/requestConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TDio {
  final Dio client;
  final Duration _defaultTimeout = const Duration(minutes: 1);

  TDio({required this.client}) {
    client.options.baseUrl = API;
    client.options.receiveTimeout =
        client.options.connectTimeout = _defaultTimeout;
    client.interceptors.add(AuthInterceptor());
  }
}

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["Authorization"] = SharedPreferences.getInstance();
    // options.headers["Accept"]="application/json";
    Future.delayed(
        const Duration(milliseconds: 650), () => handler.next(options));
  }
}

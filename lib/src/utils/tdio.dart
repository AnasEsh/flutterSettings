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
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = SharedPreferences.getInstance();
    handler.next(options);
  }
}

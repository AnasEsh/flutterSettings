import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

extension exceptionHandlers on Exception {
  String friendlyException() {
    switch (runtimeType) {
      case DioException:
        return "Server is not responding";
      case SocketException:
        return "Connection Error";
      case HttpException:
        return "Connection Error";
      case PlatformException:
        return (this as PlatformException).message ??
            "Platform Exception Occured";
      default:
        return "Unknown Exception happend";
    }
  }
}

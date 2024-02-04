import 'dart:io';

import 'package:flutter/services.dart';

extension exceptionHandlers on Exception {
  String friendlyException() {
    switch (runtimeType) {
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

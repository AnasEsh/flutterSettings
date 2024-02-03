import 'package:restore_config/src/utils/Extensions/customRegex.dart';

extension StrExtensions on String {
  String? validMobile() {
    return CustomRegexes.MOBILE.hasMatch(this) ? null : "Invalid Mobile format";
  }

  String? validEmail() {
    return CustomRegexes.EMAIL.hasMatch(this) ? null : "Invalid Email";
  }
}


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:restore_config/src/utils/di.dart';

class BaseVm with ChangeNotifier {
  AppLocalizations get localization => dependincies.get<AppLocalizations>();
  String? _error;

  final errors = StreamController<String?>.broadcast();
  String? get error => _error;

  set error(String? value) {
    _error = value;
  }

  bool _loading = false;

  bool get loading => _loading;

  toggleLoading([bool? value]) {
    if(_loading==value)
      return;
    _loading =value ?? !_loading;
    notifyListeners();
  }
}

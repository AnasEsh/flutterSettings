import 'package:dio/dio.dart';
import 'package:restore_config/src/utils/di.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseService {
  AppLocalizations get localization => dependincies.get<AppLocalizations>();

  Dio http = dependincies.get<Dio>();
}

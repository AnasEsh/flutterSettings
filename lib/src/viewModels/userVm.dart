import 'dart:async';

import 'package:restore_config/src/models/user.dart';
import 'package:restore_config/src/services/userService.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/viewModels/base.dart';

class UserViewModel extends BaseVm {
  User? _user;
  User? get user => _user;
  final _service = dependincies.get<UserService>();
  final errors = StreamController<String?>.broadcast();
  set user(User? value) {
    _user = value;
  }

  bool get loggedIn => user != null;
  UserViewModel() {
    getToken();
  }
  Future<bool> login(String email, String pswd) async {
    toggleLoading(true);
    final r = await _service.login(email, pswd);
    bool result = false;
    if (r.success) {
      result = r.result != null;

      //logged in
      if (result) {
        _user = r.result;
      } else {
        errors.add(localization.invalid_cred);
      }
    }

    if (!r.success)
      errors.add(
          r.message ?? "Something went wrong while submitting the request");

    toggleLoading();

    return result;
  }

  Future<bool> register(String name, String email, String pswd) async {
    toggleLoading(true);
    final result = await _service.register(name, email, pswd);
    if (!result.success)
      errors.add(result.message);
    else {
      errors.add("You are Welcome ${name}");
    }
    toggleLoading(false);
    return result.success;
  }

  void logout() {
    _service.logout();
    user = null;
    notifyListeners();
    return;
  }

  void getToken() async {
    final u = await _service.refreshToken();
    if (u == null) return;
    user = u;
    notifyListeners();
  }
}

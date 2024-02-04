import 'package:restore_config/src/models/user.dart';
import 'package:restore_config/src/services/userService.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/viewModels/base.dart';

class UserViewModel extends BaseVm {
  User? _user;
  User? get user => _user;
  final _service = dependincies.get<UserService>();

  set user(User? value) {
    _user = value;
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
        error = localization.invalid_cred;
      }
    }

    if (!r.success)
      this.error =
          r.message ?? "Something went wrong while submitting the request";

    toggleLoading();

    return result;
  }

  Future<bool> register(String name, String email, String pswd) async{
    await _service.register(name, email, pswd);
    return true;
  }
}


import 'package:NewsApp/utils/prefesKey.dart';
import 'package:get_storage/get_storage.dart';

import 'global.dart';

class LocalStorage {
  static final prefs = GetStorage();

  static saveUserDetails() {
    // prefs.write(PrefsKey.currentUser, userController.user.toJson());
  }

  static saveTokenDetails() {
    // prefs.write(PrefsKey.tokenUser, userController.token.toJson());
  }

  static language(String show) {
    prefs.write(PrefsKey.language, show);
  }

  static logoutUser() async {
    prefs.erase();
  }

  static bool getUserDetails() {
    Map<String, dynamic>? user = prefs.read(PrefsKey.currentUser);
    Map<String, dynamic>? token = prefs.read(PrefsKey.tokenUser);

    if (user != null) {
      // userController.user = u.User.fromJson(user);
      // userController.token = u.Token.fromJson(token!);
    }
    return user == null ? false : true;
  }
}

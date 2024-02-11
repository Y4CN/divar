import 'package:divar_app/pages/dep_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _share = locator.get<SharedPreferences>();

class ShareManager {
  ShareManager._();

  static setUserId(int userId) {
    _share.setInt("user_id", userId);
  }

  static int? getUserId() {
    return _share.getInt("user_id");
  }

  static setUserToken(String token) {
    _share.setString("user_token", token);
  }

  static String? getUserToken() {
    return _share.getString("user_token");
  }

  static Future<bool> logOut() async {
    return await _share.clear();
  }
}

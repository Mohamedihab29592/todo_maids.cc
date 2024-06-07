import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_task/core/utilies/strings.dart';

class CacheHelper {
  CacheHelper();

  Future<String?> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppStrings.token);
  }

  Future<void> writeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppStrings.token, token);
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppStrings.token);
  }
}

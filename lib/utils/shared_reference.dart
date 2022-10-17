import 'package:shared_preferences/shared_preferences.dart';

class SharedReference {
  final String ACCESS_TOKEN = "ACCESS_TOKEN";

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ACCESS_TOKEN, token);
  }

  Future<String> getAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(ACCESS_TOKEN) ?? "";
  }
}

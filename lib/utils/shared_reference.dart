import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  final String AccessToken = "ACCESS_TOKEN";
  final String RefreshToken = "REFRESH_TOKEN";

  Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AccessToken, token);
  }

  Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(RefreshToken, token);
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AccessToken) ?? "";
  }

  clearTokens() async {
    print('clear tokens');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AccessToken);
    await prefs.remove(RefreshToken);
  }
}

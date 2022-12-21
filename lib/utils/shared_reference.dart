import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  final String AccessToken = "ACCESS_TOKEN";
  final String RefreshToken = "REFRESH_TOKEN";

  Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    Get.find<Dio>().options.headers['Authorization'] = "Bearer $token";
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

  Future<bool> checkToken() async {
    try {
      await Get.find<Dio>()
          .get('https://sandbox.api.lettutor.com/category');
      return true;
    } catch (e) {
      return false;
    }
  }

  clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AccessToken);
    await prefs.remove(RefreshToken);
  }
}

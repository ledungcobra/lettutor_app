import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/user_info/user_info.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_info/access.dart';

class TokenService with AppAPI {
  final String AccessToken = "ACCESS_TOKEN";
  final String RefreshToken = "REFRESH_TOKEN";
  final String RefreshTokenExpire = "REFRESH_TOKEN_EXPIRE";

  bool logout = false;

  Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    Get.find<Dio>().options.headers['Authorization'] = "Bearer $token";
    await prefs.setString(AccessToken, token);
  }

  Future<void> saveRefreshToken(Access token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(RefreshToken, token.token!);
    await prefs.setString(RefreshTokenExpire, token.expires!);
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AccessToken) ?? "";
  }

  Future<bool> isAccessTokenValid() async {
    final prefs = await SharedPreferences.getInstance();
    final dateExpire = prefs.getString(RefreshTokenExpire) ?? "";
    final date =DateTime.parse(dateExpire);
    if (dateExpire == "") return false;
    if (DateTime.now().isBefore(date)) {
      return true;
    }
    return false;
  }

  Future<String> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(RefreshToken) ?? "";
  }

  clearTokens() async {
    logout = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AccessToken);
    await prefs.remove(RefreshToken);
    await prefs.remove(RefreshTokenExpire);
  }

  Future<String?> refresh() async {
    final refreshToken = await getRefreshToken();
    final response = await Dio().post(buildUrl('/auth/refresh-token'),
        data: {"refreshToken": refreshToken, "timezone": 7});
    final userService = Get.find<UserService>();
    final userInfo = UserInfo.fromJson(response.data);
    userService.setUserInfo(userInfo);
    await saveAccessToken(userInfo.tokens!.access!.token!);
    await saveRefreshToken(userInfo.tokens!.refresh!);
    return await getAccessToken();
  }
}

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/dto/ResponseEntity.dart';
import 'package:lettutor_app/models/user_info.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../dto/profile_dto.dart';
import '../models/history_item.dart';

class UserService with CatchError, AppAPI {
  final d.Dio dio = Get.find();
  UserInfo? _userInfo;

  setUserInfo(UserInfo? userInfo) {
    _userInfo = userInfo;
  }

  UserInfo get userInfo => _userInfo!;

  Future<ResponseEntity<UserInfo?>> register(
      String email, String password) async {
    try {
      var response = await dio.post(buildUrl('/auth/register'),
          data: {"email": email, "password": password});
      return ResponseEntity(
          data: UserInfo.fromJson(response.data), error: null);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ResponseEntity<UserInfo?>> login(String email, String password) async {
    try {
      var body = {"email": email, "password": password};
      print(body);
      var response = await dio.post(buildUrl('/auth/login'), data: body);
      return ResponseEntity(
          data: UserInfo.fromJson(response.data), error: null);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ResponseEntity<UserInfo?>> getUserInfo() async {
    try {
      var response = await dio.get(buildUrl('/user/info'));
      return ResponseEntity(
          data: UserInfo.fromJson(response.data), error: null);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ResponseEntity<List<ClassHistory>>> getHistories(
      int perPage, int page) async {
    try {
      var response = await dio.get(buildUrl('/booking/list/student'));
      var result = <ClassHistory>[];
      for (var item in response.data['data']['rows']) {
        result.add(ClassHistory.fromJson(item));
      }
      return ResponseEntity(data: result, error: null);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<int> getTotalTime() async {
    try {
      var response = await dio.get(buildUrl('/call/total'));
      return response.data['total'];
    } catch (e) {
      return 0;
    }
  }

  Future<String> sendForgotPassword(String email) async {
    try {
      var response = await dio
          .post(buildUrl('/user/forgotPassword'), data: {'email': email});
      return response.data['message'];
    } catch (e) {
      print(e);
      return "Forgot password error";
    }
  }

  Future<User> updateProfile(ProfileDto profile) async {
    try {
      var response =
          await dio.put(buildUrl('/user/info'), data: profile.toJson());
      return User.fromJson(response.data['user']);
    } catch (e) {
      return handleError(e);
    }
  }

  Future uploadAvatar(XFile file) async {
    try {
      var formData = d.FormData.fromMap({
        'avatar': await d.MultipartFile.fromFile(file.path, filename: file.name)
      });
      final response =
          await dio.post(buildUrl('/user/uploadAvatar'), data: formData);
      if (_userInfo != null) {
        _userInfo?.user = User.fromJson(response.data);
      }
      return _userInfo?.user?.avatar ?? "";
    } catch (e) {
      print(e);
      return handleError(e);
    }
  }
}

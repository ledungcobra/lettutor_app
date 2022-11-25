import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/dto/ResponseEntity.dart';
import 'package:lettutor_app/models/schedule.dart';
import 'package:lettutor_app/models/user_info.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../models/history_item.dart';

class UserService with CatchError, AppAPI {
  final Dio dio = Get.find();
  UserInfo? _userInfo;

  setUserInfo(UserInfo? userInfo){
    _userInfo = userInfo;
  }

  UserInfo get userInfo => _userInfo!;

  Future<List<Schedule>> getListSchedules() async {
    var result =
        (await readJson("schedule.json").then((value) => value.map((v) {
              return Schedule.fromJson(v);
            }).toList()));
    return result;
  }

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
      var response = await dio.post(buildUrl('/auth/login'),
          data: {"email": email, "password": password});
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

  Future<ResponseEntity<List<ClassHistory>>> getHistories(int perPage, int page) async {
    try {
      var response = await dio.get(buildUrl('/booking/list/student'));
      var result = <ClassHistory>[];
      for (var item in response.data['data']['rows']){
        result.add( ClassHistory.fromJson(item));
      }
      return ResponseEntity(
          data:result, error: null);
    } catch (e) {
      return handleError(e);
    }
  }
}

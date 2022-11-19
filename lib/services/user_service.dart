import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/dto/ResponseEntity.dart';
import 'package:lettutor_app/models/history/history.dart';
import 'package:lettutor_app/models/schedule.dart';
import 'package:lettutor_app/models/user_info.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/utils/mixing.dart';

class UserService with CatchError, AppAPI {
  final Dio dio = Get.find();

  Future<List<Schedule>> getListSchedules() async {
    var result =
        (await readJson("schedule.json").then((value) => value.map((v) {
              return Schedule.fromJson(v);
            }).toList()));
    return result;
  }

  Future<List<History>> getHistory() async {
    var result = (await readJson("history.json").then((value) => value.map((v) {
          return History.fromJson(v);
        }).toList()));
    return result;
  }

  Future<UserInfo> getUserInfo() async {
    return UserInfo.fromJson((await readObjectJson("user.json")));
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
}

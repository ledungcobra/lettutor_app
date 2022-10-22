import 'package:lettutor_app/models/history/history.dart';
import 'package:lettutor_app/models/schedule.dart';
import 'package:lettutor_app/models/user_info.dart';
import 'package:lettutor_app/utils/helper.dart';

class UserService {

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
    return UserInfo.fromJson(
        (await readObjectJson("user.json")));
  }
}

import 'package:lettutor_app/models/history/History.dart';
import 'package:lettutor_app/models/schedule.dart';
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
}

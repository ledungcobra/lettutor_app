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
}

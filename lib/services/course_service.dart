import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/utils/helper.dart';

class CourseService {
  Future<List<Course>> getCourses() async {
    await Future.delayed(Duration(seconds: 3));
    return readJson("courses.json")
        .then((value) => value.map((v) => Course.fromJson(v)).toList());
  }
}

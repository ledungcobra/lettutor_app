import 'package:get/get.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../../models/course.dart';
import '../../../services/course_service.dart';

class CoursesController with HandleUIError {
  final coursesService = Get.find<CourseService>();
  String? courseName = null;

  int page = 1;
  int perPage = 2;
  var courses = <Course>[];

  loadCourses() async {
    var r =
        await coursesService.getCoursesPagination(page, perPage, courseName);
    if (r.hasError) {
      handleError(r.error!);
      return;
    }
    courses.addAll(r.data!);
    page++;
  }

  reset() {
    courses.clear();
    page = 1;
  }
}

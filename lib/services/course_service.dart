import 'package:get/get.dart';
import 'package:lettutor_app/dto/ResponseEntity.dart';
import 'package:lettutor_app/models/book.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/utils/mixing.dart';

class CourseService with AppAPI, CatchError {
  Future<List<Course>> getCourses() async {
    await Future.delayed(Duration(seconds: 1));
    return readJson("courses.json")
        .then((value) => value.map((v) => Course.fromJson(v)).toList());
  }

  Future<List<Book>> getBooks() async {
    await Future.delayed(Duration(seconds: 1));
    return readJson("books.json")
        .then((value) => value.map((v) => Book.fromJson(v)).toList());
  }

  Future<ResponseEntity<List<Course>>> getCoursesPagination(int page, int perPage) async {
    try {
      await Future.delayed(Duration(milliseconds: 1000));
      var response = await dio.get(buildUrl("/course?page=$page&size=$perPage"));
      var courses = <Course>[];
      for(var course in response.data['data']['rows']){
        courses.add(Course.fromJson(course));
      }
      return ResponseEntity(data: courses);
    } catch (e) {
      return handleError(e);
    }
  }
}

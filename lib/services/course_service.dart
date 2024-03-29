import 'package:get/get.dart';
import 'package:lettutor_app/models/response_entity.dart';
import 'package:lettutor_app/models/course/course.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../models/book/book.dart';

class CourseService with AppAPI, CatchError {
  final userService = Get.find<UserService>();

  Future<ResponseEntity<List<Course>>> getCoursesPagination(int page, int perPage, [String? courseName]) async {
    try {
      var query = "page=$page&size=$perPage";
      if(courseName != null){
        query +='&q=$courseName';
      }
      var response = await dio.get(buildUrl("/course?$query"));
      print(query);
      var courses = <Course>[];
      for(var course in response.data['data']['rows']){
        courses.add(Course.fromJson(course));
      }
      return ResponseEntity(data: courses);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ResponseEntity<List<Book>>> getBooksPagination(int page, int perPage, [String? name]) async {
    try {
      var query = 'page=$page&size=$perPage';
      if(name != null){
        query += '&q=$name';
      }
      var response = await dio.get(buildUrl("/e-book?$query"));
      var courses = <Book>[];
      for(var course in response.data['data']['rows']){
        courses.add(Book.fromJson(course));
      }
      return ResponseEntity(data: courses);
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ResponseEntity<Course>> getCourseDetail(String id) async {
    print("Load course work");
    try {
      var response = await dio.get(buildUrl("/course/$id"));
      return ResponseEntity(data:Course.fromJson(response.data['data']) );
    } catch (e) {
      return handleError(e);
    }
  }
}

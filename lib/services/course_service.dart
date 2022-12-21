import 'package:get/get.dart';
import 'package:lettutor_app/dto/ResponseEntity.dart';
import 'package:lettutor_app/models/book.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/utils/mixing.dart';

class CourseService with AppAPI, CatchError {
  final userService = Get.find<UserService>();

  Future<List<Book>> getBooks() async {
    await Future.delayed(Duration(seconds: 1));
    return readJson("books.json")
        .then((value) => value.map((v) => Book.fromJson(v)).toList());
  }

  Future<ResponseEntity<List<Course>>> getCoursesPagination(int page, int perPage) async {
    try {
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

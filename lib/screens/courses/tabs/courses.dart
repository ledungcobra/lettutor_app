import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/screens/course_overview/course_overview.dart';
import 'package:lettutor_app/screens/courses/widgets/course_item.dart';
import 'package:lettutor_app/services/course_service.dart';
import 'package:lettutor_app/widgets/loading.dart';

class CoursesTab extends StatelessWidget {

  CourseService _courseService = Get.find();
  late BuildContext context;

  CoursesTab({Key? key}) : super(key: key){
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return AlertDialog(
            content: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          return _coursesList(snapshot.data as List<Course>);
        }
        return Loading();
      },
      future: _courseService.getCourses(),
    );
  }


  _onTap(Course course) {

    Navigator.push(context, MaterialPageRoute(builder: (context) => CourseOverview(course: course),));
  }

  Widget _coursesList(List<Course> courses) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: courses.map((c) =>
            CourseItem(course: c, onTap: () => _onTap(c))).toList(),
      ),
    );
  }
}

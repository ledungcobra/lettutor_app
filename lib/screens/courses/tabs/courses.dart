import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/screens/course_detail/course_details.dart';
import 'package:lettutor_app/screens/courses/widgets/course_item.dart';
import 'package:lettutor_app/services/course_service.dart';
import 'package:lettutor_app/widgets/loading.dart';

class CoursesTab extends StatelessWidget {

  CoursesTab({Key? key}) : super(key: key){
    _courseService = GetIt.I.get<CourseService>();
  }
  late CourseService _courseService;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetails(course: course),));
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

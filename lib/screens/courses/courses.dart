import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/screens/course_detail/course_details.dart';
import 'package:lettutor_app/screens/courses/widgets/course_item.dart';
import 'package:lettutor_app/services/course_service.dart';
import 'package:lettutor_app/widgets/loading.dart';

class Courses extends StatelessWidget {
  late CourseService _courseService;
  late BuildContext context;

  Courses({Key? key}) : super(key: key) {
    _courseService = GetIt.I.get<CourseService>();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses',),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AlertDialog(
              content: Text('Error when loading courses'),
            );
          }
          if (snapshot.hasData) {
            return _coursesList(snapshot.data as List<Course>);
          }
          return Loading();
        },
        future: _courseService.getCourses(),
      ),
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

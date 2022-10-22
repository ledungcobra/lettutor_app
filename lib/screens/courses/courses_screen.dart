import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/courses/tabs/books.dart';
import 'package:lettutor_app/screens/courses/tabs/courses.dart';
import 'package:lettutor_app/services/course_service.dart';

class CoursesScreen extends StatefulWidget {
  CourseService _courseService = Get.find();

  CoursesScreen({Key? key}) : super(key: key);
  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with TickerProviderStateMixin {
  late BuildContext context;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Courses',
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.school, color: Colors.black,)),
              Tab(icon: Icon(Icons.book, color: Colors.black,)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CoursesTab(),
            BooksTab(),
          ],
        ),
      ),
    );
  }
}

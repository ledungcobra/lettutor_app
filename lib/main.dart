import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/courses/courses_screen.dart';
import 'package:lettutor_app/screens/home/home_controller.dart';
import 'package:lettutor_app/screens/home/home_screen.dart';
import 'package:lettutor_app/screens/login/login_screen.dart';
import 'package:lettutor_app/screens/settings/settings_screen.dart';
import 'package:lettutor_app/screens/tutors/tutors_controller.dart';
import 'package:lettutor_app/screens/tutors/tutors_screen.dart';
import 'package:lettutor_app/screens/upcoming/upcoming_screen.dart';
import 'package:lettutor_app/services/course_service.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/utils/mixing.dart';

import 'screens/course_details/controllers/course_details_controller.dart';

void main() {
  setUpIOC();
  runApp(const App());
}

void setUpIOC() {
  Get.put(TutorService());
  Get.put(UserService());
  Get.put(CourseService());
  Get.lazyPut(()=> HomeController());
  Get.lazyPut(() => TutorsController());
  Get.lazyPut(() => CourseDetailsController());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Lettutor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
        backgroundColor: Colors.white, foregroundColor: Colors.black),
    ),
    home: LoginScreen());
  }
}

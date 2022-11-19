import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/home/home_controller.dart';
import 'package:lettutor_app/screens/login/login_controller.dart';
import 'package:lettutor_app/screens/login/login_screen.dart';
import 'package:lettutor_app/screens/signup/sign_up_controller.dart';
import 'package:lettutor_app/screens/tutors/tutors_controller.dart';
import 'package:lettutor_app/services/course_service.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/services/user_service.dart';

import 'screens/course_details/controllers/course_details_controller.dart';
import 'utils/shared_reference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpIOC();
  runApp(const App());
}

setUpIOC() async {
  var dio = Dio();
  var tokenService = TokenService();
  var accessToken = await tokenService.getAccessToken();
  if(accessToken.isNotEmpty){
    dio.options.headers['Authorization'] = "Bearer $accessToken";
  }
  dio.options.headers['Content-Type'] = 'application/json';

  Get.put(dio);
  Get.put(tokenService);
  Get.put(TutorService());
  Get.put(UserService());
  Get.put(CourseService());
  Get.put(SignUpController());
  Get.put(LoginController());

  Get.lazyPut(() => TutorsController());
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

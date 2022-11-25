import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_app/screens/home/home_controller.dart';
import 'package:lettutor_app/screens/login/login_controller.dart';
import 'package:lettutor_app/screens/login/login_screen.dart';
import 'package:lettutor_app/screens/signup/sign_up_controller.dart';
import 'package:lettutor_app/screens/tutors/tutors_controller.dart';
import 'package:lettutor_app/services/course_service.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'screens/course_details/controllers/course_details_controller.dart';
import 'screens/courses/tabs/books_controller.dart';
import 'services/utils_service.dart';
import 'utils/shared_reference.dart';
import 'widgets/refresh_scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpIOC();
  runApp(const App());
}

setUpIOC() async {
  var dio = Dio();
  var tokenService = TokenService();
  Get.put(tokenService);

  var accessToken = await tokenService.getAccessToken();
  if (accessToken.isNotEmpty) {
    dio.options.headers['Authorization'] = "Bearer $accessToken";
  }
  dio.options.headers['Content-Type'] = 'application/json';
  Get.put(dio);

  var utilService = UtilService();
  await utilService.init();
  Get.put(utilService);
  Get.put(DateFormat('yyyy-MM-dd hh:mm'));
  Get.put(TutorService());
  Get.put(UserService());
  Get.put(CourseService());
  Get.put(SignUpController());
  Get.put(LoginController());
  Get.put(HomeController());
  Get.put(BooksController());
  Get.put(CourseDetailsController());
  Get.put(TutorsController());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerBuilder: () => MaterialClassicHeader(),
      footerBuilder: () => ClassicFooter(),
      enableLoadingWhenNoData: false,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      shouldFooterFollowWhenNotFull: (state) {
        // If you want load more with noMoreData state ,may be you should return false
        return false;
      },
      child: GetMaterialApp(
          localizationsDelegates: const [
            RefreshLocalizations.delegate,
          ],
          builder: (context, child){
            return ScrollConfiguration(behavior: RefreshScrollBehavior(), child: child!);
          },
          title: 'Lettutor',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Roboto',
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white, foregroundColor: Colors.black),
          ),
          home: LoginScreen()),
    );
  }
}

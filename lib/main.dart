import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_app/screens/login/login_controller.dart';
import 'package:lettutor_app/screens/login/login_screen.dart';
import 'package:lettutor_app/screens/signup/sign_up_controller.dart';
import 'package:lettutor_app/screens/tutors/tutors_controller.dart';
import 'package:lettutor_app/services/chat_service.dart';
import 'package:lettutor_app/services/course_service.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'screens/course_details/controllers/course_details_controller.dart';
import 'screens/upcoming/upcoming_controller.dart';
import 'services/utils_service.dart';
import 'services/token_service.dart';
import 'utils/theme_controller.dart';
import 'widgets/refresh_scroll_behavior.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  await setUpIOC();
  runApp(App());
}

Future initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

setUpIOC() async {
  var tokenService = TokenService();
  final dio = Dio();
  Get.put(dio);
  Get.put(tokenService);
  await configDio(tokenService, dio);

  final themeController = ThemeController();
  await themeController.init();

  final utilService = UtilService();
  Get.put(utilService);
  Get.put(themeController);
  Get.put(DateFormat('yyyy-MM-dd hh:mm'));
  Get.put(TutorService());
  Get.put(UserService());
  Get.put(ChatService());
  Get.put(CourseService());
  Get.put(SignUpController());
  Get.put(LoginController());
  Get.put(CourseDetailsController());
  Get.put(TutorsController());
  Get.put(UpcomingController());
}

Future<Dio> configDio(TokenService tokenService, Dio dio) async {
  var accessToken = await tokenService.getAccessToken();
  if (accessToken.isNotEmpty) {
    dio.options.headers['Authorization'] = "Bearer $accessToken";
  }
  dio.options.headers['Content-Type'] = 'application/json';
  dio.interceptors.add(InterceptorsWrapper(
    onError: (e, handler) => handleError(e, tokenService, dio, handler),
  ));
  return dio;
}

Future<void> handleError(
    error, TokenService tokenService, Dio dio, handler) async {
  final statusCode = error.response?.statusCode;
  if (statusCode == 403 || statusCode == 401) {
    if (!await tokenService.isRefreshTokenValid()) {
      tokenService.clearTokens();
      Get.offAll(() => LoginScreen());
      throw error;
    }
    final accessToken = await tokenService.refresh();
    dio.options.headers['Authorization'] = "Bearer $accessToken";
    final cloneRequest = await retry(dio, error);
    return handler.resolve(cloneRequest);
  }
  throw error;
}

Future<dynamic> retry(Dio dio, error) async {
  final cloneRequest = await dio.request(
    error.requestOptions.path,
    data: error.requestOptions.data,
    queryParameters: error.requestOptions.queryParameters,
  );
  return cloneRequest;
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _darkTheme = ThemeData(
    accentColor: Colors.red,
    primaryColor: Colors.amber,
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey, foregroundColor: Colors.white),
    brightness: Brightness.dark,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.amber,
      disabledColor: Colors.grey,
    ),
  );

  final _lightTheme = ThemeData(
    accentColor: Colors.pink,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey, foregroundColor: Colors.black),
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      disabledColor: Colors.grey,
    ),
  );

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
          theme: _lightTheme,
          darkTheme: _darkTheme,
          themeMode: ThemeMode.system,
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: RefreshScrollBehavior(),
              child: child!,
            );
          },
          title: 'Lettutor',
          debugShowCheckedModeBanner: false,
          home: LoginScreen()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/response_entity.dart';
import 'package:lettutor_app/screens/login/login_controller.dart';
import 'package:lettutor_app/screens/login/widgets/FormFields.dart';
import 'package:lettutor_app/screens/login/widgets/footer.dart';
import 'package:lettutor_app/screens/tab_bar_screen/tab_bar_screen.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/services/utils_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/services/token_service.dart';
import 'package:lettutor_app/widgets/button.dart';

import '../../models/user_info/user_info.dart';
import '../../widgets/loading.dart';

class LoginScreen extends StatelessWidget with HandleUIError {
  final loginController = Get.find<LoginController>();
  final userService = Get.find<UserService>();
  final tokenService = Get.find<TokenService>();
  final utilService = Get.find<UtilService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // _handleLogin();
    checkForLogin();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _introductionSection(),
                      const SizedBox(height: 10),
                      FormFields(formKey: formKey),
                      const SizedBox(height: 10),
                      Button(onClick: _handleLogin, title: 'LOGIN'),
                      Footer(
                        googleLogin: _handleLoginGoogle,
                        facebookLogin: () => print("Not supported"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(() => loginController.loading.isTrue ? Loading() : Container())
          ],
        ),
      ),
    );
  }

  _handleLoginGoogle() async {
    final response = await userService.loginGoogle();
    await _processLogin(response);
  }

  void checkForLogin() async {
    if (tokenService.logout) {
      print('Logout clicked');
      return;
    }
    final userInfo = await userService.getUserInfo();
    if (userInfo.hasError) {
      return;
    }
    userService.setUserInfo(userInfo.data);
    await utilService.init();
    Get.offAll(() => TabBarScreen());
  }

  void _handleLogin() async {
    try {
      loginController.loading.value = true;
      var response = await userService.login(
          loginController.email.value, loginController.password.value);
      await _processLogin(response);
    } finally {
      loginController.loading.value = false;
    }
  }

  Future _processLogin(ResponseEntity<UserInfo?> response) async {
    if (response.hasError) {
      handleError(response.error!);
      return;
    } else {
      Get.snackbar("Success", "Login success",
          backgroundColor: Colors.green, colorText: Colors.white);
      userService.setUserInfo(response.data);
      await tokenService.saveAccessToken(response.data!.tokens!.access!.token!);
      await tokenService.saveRefreshToken(response.data!.tokens!.refresh!);
      await utilService.init();
      Get.offAll(() => TabBarScreen());
    }
  }

  Widget _introductionSection() {
    return Column(
      children: [
        SizedBox(
          height: 0.3 * Get.height,
          child: Image.asset(getAssetImage("intro_photo.png")),
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
          'Say hello your English tutors',
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Become fluent faster through one on one video chat lessons tailored to your goals.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/signup/widgets/FormFields.dart';
import 'package:lettutor_app/screens/signup/widgets/footer.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/button.dart';

import '../../services/user_service.dart';
import '../../widgets/loading.dart';
import '../tab_bar_screen/tab_bar_screen.dart';
import 'sign_up_controller.dart';

class SignUpScreen extends StatelessWidget with HandleUIError {
  SignUpController signUpController = Get.find();
  UserService userService = Get.find();

  SignUpScreen({Key? key}) : super(key: key);

  _handleSignUp() async {
    var state = signUpController.formKey.currentState!;
    if (!state.validate()) {
      Get.snackbar("Errors", "There are some errors");
      return;
    }

    signUpController.loading.value = true;
    var response = await userService.register(
        signUpController.email.value, signUpController.password.value);
    if (response.hasError) {
      signUpController.loading.value = false;
      return handleError(response.error!);
    }
    userService.setUserInfo(response.data);
    Get.snackbar('Success', 'Register success', backgroundColor: Colors.green);
    signUpController.loading.value = false;
    Get.offAll(() => TabBarScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      FormFields(),
                      const SizedBox(height: 10),
                      Button(onClick: _handleSignUp, title: 'SIGN UP'),
                      Footer(),
                    ],
                  ),
                ),
              ),
            ),
            Obx(() => signUpController.loading.value ? Loading() : Container())
          ],
        ),
      ),
    );
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/login/widgets/FormFields.dart';
import 'package:lettutor_app/screens/login/widgets/footer.dart';
import 'package:lettutor_app/screens/tab_bar_screen/tab_bar_screen.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/widgets/button.dart';

class LoginScreen extends StatelessWidget {
  late double _width;
  late double _height;

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _introductionSection(),
                  const SizedBox(height: 10),
                  FormFields(width: _width),
                  const SizedBox(height: 10),
                  Button(onClick: _handleLogin, title: 'LOGIN'),
                  Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _introductionSection() {
    return Column(
      children: [
        SizedBox(
          height: 0.3 * _height,
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

  void _handleLogin() {
    Get.offAll(()=>TabBarScreen());
  }
}

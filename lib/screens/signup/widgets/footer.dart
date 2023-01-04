import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/login/login_screen.dart';
import 'package:lettutor_app/screens/login/widgets/svg_icon_button.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const icons = ["facebook.svg", "google.svg"];
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        const Text('Or continue with'),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIconButton(image: "facebook.svg"),
            SvgIconButton(
              image: "google.svg",
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: _openSignIn, child: Text('Sign In'))
          ],
        )
      ],
    );
  }

  void _openSignIn() {
    Get.to(LoginScreen());
  }
}

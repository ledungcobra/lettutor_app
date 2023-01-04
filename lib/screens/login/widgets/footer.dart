import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/login/widgets/svg_icon_button.dart';
import 'package:lettutor_app/screens/signup/sign_up.dart';

class Footer extends StatelessWidget {
  final Function googleLogin;
  final Function facebookLogin;

  Footer({Key? key, required this.googleLogin, required this.facebookLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        const Text('Or continue with'),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIconButton(image: "facebook.svg"),
            SvgIconButton(
                image: "google.svg", onClick: googleLogin),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Not a member yet?"),
            TextButton(onPressed: _openSignUp, child: Text('Sign up'))
          ],
        )
      ],
    );
  }

  void _openSignUp() {
    Get.to(SignUpScreen());
  }
}

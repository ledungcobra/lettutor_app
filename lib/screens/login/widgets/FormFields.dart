import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/forgot_password/forgot_password.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/helper.dart';

import '../login_controller.dart';

class FormFields extends StatelessWidget {
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Get.width,
          child: Text(
            'EMAIL',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your email',
          ),
          validator: validateEmail,
          onChanged: (value) => loginController.email.value = value,
          onSaved: (value) => loginController.email.value = value ?? "",
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: Get.width,
          child: Text(
            'PASSWORD',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
                suffixIcon: Container(
                  child: IconButton(
                      onPressed: () {
                        loginController.showPassword.toggle();
                      },
                      icon: loginController.showPassword.value
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off)),
                )),
            validator: validatePassword,
            obscureText: !loginController.showPassword.value,
            onChanged: (value) => loginController.password.value = value,
            onSaved: (value) => loginController.password.value = value ?? "",
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(children: [
          TextButton(
            onPressed: _showForgotPassword,
            style: ButtonStyle(alignment: Alignment.topLeft),
            child: const Text('Forgot Password?'),
          ),
        ])
      ],
    );
  }

  void _showForgotPassword() {
    Get.to(ForgotPasswordScreen());
  }
}

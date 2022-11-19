import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/forgot_password/forgot_password.dart';
import 'package:lettutor_app/utils/helper.dart';

import '../sign_up_controller.dart';

class FormFields extends StatelessWidget {
  SignUpController signUpController = Get.find();

  FormFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpController.formKey,
      child: Column(
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
            initialValue: signUpController.email.value,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your email',
            ),
            validator: validateEmail,
            onChanged: (value)=>  signUpController.email.value = value,
            onSaved: (value) {
              signUpController.email.value = value ?? "";
            },
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
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
                suffixIcon: Container(
                  child: IconButton(
                      onPressed: () {
                        signUpController.showPassword1.value =
                            !signUpController.showPassword1.value;
                      },
                      icon: signUpController.showPassword1.value
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off)),
                )),
            validator: validatePassword,
            obscureText: !signUpController.showPassword1.value,
            onChanged: (value) => signUpController.password.value = value  ,
            onSaved: (value) => signUpController.password.value = value ?? "",
          ),
          SizedBox(height: 10),
          SizedBox(
            width: Get.width,
            child: Text(
              'RePassword',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
                suffixIcon: Container(
                  child: IconButton(
                      onPressed: () {
                        signUpController.showPassword2.value =
                            !signUpController.showPassword2.value;
                      },
                      icon: signUpController.showPassword2.value
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off)),
                )),
            validator: validatePassword,
            obscureText: !signUpController.showPassword2.value,
            onChanged: (value) => signUpController.rePassword.value = value ,
            onSaved: (value) => signUpController.rePassword.value = value ?? "",
          ),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            TextButton(
              onPressed: _openForgotPassword,
              style: ButtonStyle(alignment: Alignment.topLeft),
              child: const Text('Forgot Password?'),
            ),
          ])
        ],
      ),
    );
  }

  void _openForgotPassword() {
    Get.to(ForgotPasswordScreen());
  }
}

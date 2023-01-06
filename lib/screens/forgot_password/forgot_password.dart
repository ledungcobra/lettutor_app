import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/widgets/button.dart';

import '../../services/user_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final userService = Get.find<UserService>();
  final email = "".obs;

  _processResetPassword() async {
    final errorMessage = validateEmail(email.value);
    if (errorMessage != null) {
      Get.snackbar('Error', errorMessage,
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }
    final response = await userService.sendForgotPassword(email.value);
    Get.snackbar('Error', response,
        colorText: Colors.white, backgroundColor: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot password"),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
          child: Form(
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  "Forgot password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "Please enter your email address to reset your password",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your email',
                  ),
                  onChanged: (v) => email.value = v,
                  validator: validateEmail,
                  onSaved: (value) => email.value = value ?? "",
                ),
                const SizedBox(height: 15),
                Button(
                  title: 'Send',
                  onClick: _processResetPassword,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

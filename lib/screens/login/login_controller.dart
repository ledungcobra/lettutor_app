import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final showPassword = false.obs;
  final email = "wkn09800@xcoxc.com".obs;
  // final email = "student@lettutor.com".obs;
  final password = "password".obs;
  // final password = "123456".obs;
  final loading = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  reset() {
    showPassword.value = false;
    email.value = "";
    password.value = "";
  }
}

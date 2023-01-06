import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final showPassword1 = false.obs;
  final showPassword2 = false.obs;
  final email = "".obs;
  final password = "".obs;
  final rePassword = "".obs;
  final loading = false.obs;



  reset() {
    showPassword1.value = false;
    showPassword2.value = false;
    email.value = "";
    password.value = "";
    rePassword.value = "";
  }
}

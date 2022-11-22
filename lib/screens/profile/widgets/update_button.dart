import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/widgets/button.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(title: 'Update', onClick: (){
      Get.snackbar('Notification', "Profile updated", backgroundColor: Colors.lightGreen);
    });
  }
}
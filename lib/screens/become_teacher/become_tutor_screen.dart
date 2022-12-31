import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/response_entity.dart';
import 'package:lettutor_app/screens/become_teacher/become_tutor_controller.dart';
import 'package:lettutor_app/screens/become_teacher/widgets/my_text_form_field.dart';
import 'package:lettutor_app/services/user_service.dart';

import '../../models/user_info/user_info.dart';
import '../../utils/mixing.dart';
import '../../widgets/loading.dart';

class BecomeTeacherScreen extends StatefulWidget {
  const BecomeTeacherScreen({Key? key}) : super(key: key);

  @override
  State<BecomeTeacherScreen> createState() => _BecomeTeacherScreenState();
}

class _BecomeTeacherScreenState extends State<BecomeTeacherScreen>
    with HandleUIError {
  final userService = Get.find<UserService>();
  UserInfo? userInfo;

  BecomeTutorController get controller => Get.find<BecomeTutorController>();

  @override
  void initState() {
    Get.put(BecomeTutorController(), tag: 'become_tutor_controller');
    userService.getUserInfo().then((x)=>handleUserResponse(x));
    super.initState();
  }

  handleUserResponse(ResponseEntity<UserInfo?> response) {
    if (response.hasError) {
      handleError(response.error!);
      return;
    }
    setState(() {
      userInfo = response.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Become Tutor Form"),
      ),
      body: userInfo == null
          ? Center(child: Loading())
          : SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextFormField(onDone: (v) {}, placeHolder: 'Tutor name'),
                  SizedBox(height: 10),
                  MyTextFormField(onDone: (v) {}, placeHolder: 'Interests'),
                  SizedBox(height: 10),
                  MyTextFormField(onDone: (v) {}, placeHolder: 'Education'),
                  MyTextFormField(onDone: (v) {}, placeHolder: 'Experience'),
                  SizedBox(height: 10),
                  MyTextFormField(onDone: (v) {}, placeHolder: 'Profession'),
                  SizedBox(height: 10),
                  MyTextFormField(onDone: (v) {}, placeHolder: 'Languages'),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/become_teacher/become_tutor_controller.dart';
import 'package:lettutor_app/screens/become_teacher/sub_screen/step1.dart';
import '../../utils/mixing.dart';

class BecomeTutorScreen extends StatefulWidget {
  const BecomeTutorScreen({Key? key}) : super(key: key);

  @override
  State<BecomeTutorScreen> createState() => _BecomeTutorScreenState();
}

class _BecomeTutorScreenState extends State<BecomeTutorScreen>
    with HandleUIError {
  BecomeTutorController get controller =>
      Get.find<BecomeTutorController>(tag: 'become_tutor_controller');
  final mainScreen = Step1();

  @override
  void initState() {
    Get.put(BecomeTutorController(), tag: 'become_tutor_controller');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Become Tutor Form"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: Center(
            child: SingleChildScrollView(
              child: mainScreen,
            ),
          ),
        ),
      ),
    );
  }
}

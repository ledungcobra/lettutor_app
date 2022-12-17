import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profile_controller.dart';

class StudyScheduleTextFormField extends StatelessWidget {
  final controller = Get.find<ProfileController>(tag: 'profile_controller');
  final String hintText;
  final String title;
  final String value;

  StudyScheduleTextFormField({
    Key? key,
    required this.hintText,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          maxLines: null,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          initialValue: value,
          onSaved: (val) => controller.studySchedule.value = val ?? "",
          onChanged: (v) => controller.studySchedule.value = v,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../become_tutor_controller.dart';

class NameFormField extends StatelessWidget {

  final controller = Get.find<BecomeTutorController>(tag: 'become_tutor_controller');
  final String hintText;
  final String title;

  NameFormField({
    Key? key,
    required this.hintText,
    required this.title,
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
          initialValue: controller.name.value,
          onSaved: (val) => controller.name.value = val ?? "",
          onChanged: (v) => controller.name.value = v,
        ),
      ],
    );
  }
}

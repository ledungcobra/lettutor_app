import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/profile/profile_controller.dart';

class PhoneTextFormField extends StatelessWidget {
  final controller = Get.find<ProfileController>(tag: 'profile_controller');

  PhoneTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "Phone Number",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter your phone number",
          ),
          onChanged: (v) => controller.phone.value = v,
          initialValue: controller.phone.value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            } else {
              if (!RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(value)) {
                return 'Invalid phone number';
              }
            }
            return null;
          },
          onSaved: (val) => controller.phone.value = val ?? "",
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class PhoneTextFormField extends StatelessWidget {
  final String phoneNumber;
  const PhoneTextFormField({
    Key? key, required this.phoneNumber,
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
                color: Colors.black,
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
          initialValue: phoneNumber,
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
          onSaved: (val) {},
        ),
      ],
    );
  }
}

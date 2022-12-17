import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  final String email;
  EmailTextFormField({
    Key? key, required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "Email address",
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
          enabled: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter your email",
          ),
          initialValue: email,
          onSaved: (val) {},
        ),
      ],
    );
  }
}
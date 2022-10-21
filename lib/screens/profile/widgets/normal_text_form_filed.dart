import 'package:flutter/material.dart';

class NormalTextFormField extends StatelessWidget {
  const NormalTextFormField({
    Key? key,
    required this.hintText,
    required this.title,
    required this.name,
  }) : super(key: key);
  final String hintText;
  final String title;
  final String name;
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
          keyboardType: TextInputType.none,
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
          initialValue: name,
          onSaved: (val) {},
        ),
      ],
    );
  }
}

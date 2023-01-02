import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String? initialValue;
  final Function(String) onDone;
  final String placeHolder;

  const MyTextFormField(
      {Key? key,
      this.initialValue,
      required this.onDone,
      required this.placeHolder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              placeHolder,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter ${placeHolder.toLowerCase()}",
          ),
          initialValue: initialValue,
          onSaved: (val) {
            onDone(val ?? "");
          },
          onChanged: (v)=> onDone(v),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';


class TitleLine extends StatelessWidget {

  const TitleLine({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 30,
          child: Divider(
            endIndent: 10,
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const Expanded(
          child: Divider(
            indent: 10,
          ),
        ),
      ],
    );
  }
}
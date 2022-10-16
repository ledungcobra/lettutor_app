import 'package:flutter/material.dart';
import 'package:lettutor_app/models/course_preview.dart';
import 'package:lettutor_app/utils/constants.dart';

class CoursePreviewButton extends StatelessWidget {
  final CoursePreview coursePreview;

  CoursePreviewButton({Key? key, required this.coursePreview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          coursePreview.name,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Find out",
              style: const TextStyle(fontSize: 16, color: PRIMARY_COLOR),
            ),
          ),
        )

      ],
    );
  }
}

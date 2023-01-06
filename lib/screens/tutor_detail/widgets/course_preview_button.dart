import 'package:flutter/material.dart';
import 'package:lettutor_app/utils/constants.dart';

import '../../../models/tutor_detail/course.dart';

class CoursePreviewButton extends StatelessWidget {
  final Course coursePreview;
  final Function() onClick;

  CoursePreviewButton(
      {Key? key, required this.coursePreview, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          coursePreview.name!,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
          child: TextButton(
            onPressed: onClick,
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

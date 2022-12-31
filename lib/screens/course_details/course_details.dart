import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/course/course.dart';
import 'package:lettutor_app/screens/course_details/tabs/details.dart';
import 'package:lettutor_app/screens/course_details/tabs/pdf_file.dart';

import 'controllers/course_details_controller.dart';

class CourseDetails extends StatelessWidget {
  final Course course;
  final controller = Get.find<CourseDetailsController>();

  CourseDetails({required this.course, required int selectedIndex}) {
    controller.selectedIndex.value = selectedIndex;
    controller.course.value = course;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (index) async {
              if (index == 1) {
                await controller.loadPdf();
              }
            },
            tabs: const [
              Icon(Icons.details, color: Colors.black),
              Icon(Icons.picture_as_pdf, color: Colors.black)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Details(
              course: course,
              changeSelectedIndex: (index) =>
                  controller.selectedIndex.value = index,
            ),
            PdfFile()
          ],
        ),
      ),
    );
  }
}

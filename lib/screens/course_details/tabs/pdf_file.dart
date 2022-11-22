import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/course_details/controllers/course_details_controller.dart';
import 'package:lettutor_app/widgets/loading.dart';

class PdfFile extends GetView<CourseDetailsController> {

  PdfFile();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(controller.document.value == null){
        return Loading();
      }
      return PDFViewer(document: controller.document.value!);
    });
  }
}

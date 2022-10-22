import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/course.dart';

class CourseDetailsController extends GetxController {
  var document = Rx<PDFDocument?>(null);
  var selectedIndex = 0.obs;
  var course = Rx<Course?>(null);

  String? get bookUrl =>
      course.value != null && course.value!.topics!.length > selectedIndex.value
          ? course.value!.topics![selectedIndex.value].nameFile
          : null;

  loadPdf() async {
    if (bookUrl == null) return;
    document.value = await PDFDocument.fromURL(
      bookUrl!,
    );
  }
}

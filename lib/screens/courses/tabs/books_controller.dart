import 'package:get/get.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../../models/book/book.dart';
import '../../../services/course_service.dart';

class BooksController extends GetxController with HandleUIError {
  final CourseService _courseService = Get.find();
  String? bookName = null;
  int page = 1;
  int perPage = 2;
  var books = <Book>[];

  loadBooks() async {
    var r = await _courseService.getBooksPagination(page, perPage, bookName);
    if (r.hasError) {
      handleError(r.error!);
      return;
    }
    books.addAll(r.data!);
    page++;
  }

  void init() {
    reset();
    loadBooks();
  }

  reset() {
    books.clear();
    page = 1;
  }
}

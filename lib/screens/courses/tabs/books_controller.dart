import 'package:get/get.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../../models/book.dart';
import '../../../services/course_service.dart';

class BooksController extends GetxController with HandleUIError{

  CourseService _courseService = Get.find();

  int page = 1;
  int perPage = 2;
  var books = <Book>[];

  loadBooks() async {
    print('Current page=$page size=$perPage');
    await Future.delayed(const Duration(milliseconds: 500));
    var r = await _courseService.getBooksPagination(page, perPage);
    if (r.hasError) {
      handleError(r.error!);
      return;
    }
    books.addAll(r.data!);
    page++;
  }

  @override
  void onInit() {
    super.onInit();
    loadBooks();
  }

}
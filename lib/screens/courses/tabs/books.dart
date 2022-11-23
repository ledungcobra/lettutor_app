import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/book.dart';
import 'package:lettutor_app/screens/courses/widgets/book_item.dart';
import 'package:lettutor_app/services/course_service.dart';
import 'package:lettutor_app/widgets/loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../widgets/load_more_footer.dart';
import 'books_controller.dart';

class BooksTab extends StatefulWidget {
  BooksTab({Key? key}) : super(key: key);

  @override
  State<BooksTab> createState() => _BooksTabState();
}

class _BooksTabState extends State<BooksTab> {
  final controller = Get.find<BooksController>();
  final GlobalKey _refresherKey = GlobalKey();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      key: _refresherKey,
      enablePullUp: true,
     
      header: WaterDropHeader(),
      physics: BouncingScrollPhysics(),
      footer: LoadMoreFooter(),
      controller: refreshController,
      onLoading: () async {
        await controller.loadBooks();
        if(mounted){
          setState(() {});
        }
        refreshController.loadComplete();
      },
      child: _listBooks(controller.books),
    );
  }

  _listBooks(List<Book> books) {
    return ListView.builder(
      itemBuilder: (context, index) => BookItem(books[index]),
      itemCount: books.length,
    );
  }
}

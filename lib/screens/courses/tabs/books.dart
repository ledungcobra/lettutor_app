import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lettutor_app/models/book.dart';
import 'package:lettutor_app/screens/courses/widgets/BookItem.dart';
import 'package:lettutor_app/services/course_service.dart';
import 'package:lettutor_app/widgets/loading.dart';

class BooksTab extends StatelessWidget {
  late CourseService _courseService;

  BooksTab({Key? key}) : super(key: key) {
    _courseService = GetIt.I.get<CourseService>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return AlertDialog(
            content: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          return _listBooks(snapshot.data as List<Book>);
        }
        return Loading();
      }),
      future: _courseService.getBooks(),
    );
  }

  _listBooks(List<Book> books) {
    return ListView.builder(
      itemBuilder: (context, index) => BookItem(books[index]),
      itemCount: books.length,
    );
  }
}

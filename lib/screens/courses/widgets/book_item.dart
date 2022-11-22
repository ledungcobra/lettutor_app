import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/loading.dart';
import 'package:lettutor_app/widgets/loading_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/book.dart';

class BookItem extends StatelessWidget with Dimension {
  final Book book;

  const BookItem(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTapBookItem,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.only(bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width(context),
              height: 0.4 * height(context),
              child: LoadingImage(src: book.imageUrl, boxFit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(book.name ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 10),
                  Text(book.description ?? "",
                      style: TextStyle(color: Colors.black45)),
                  SizedBox(height: 30),
                  Text(
                    LEVEL_TO_TEXT[book.level ?? ""] ?? "",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  _handleTapBookItem() async {
    if(!await launchUrl(Uri.parse(book.fileUrl!))){
      Get.snackbar('Error', "Cannot open files", backgroundColor: Colors.red);
    }
  }
}

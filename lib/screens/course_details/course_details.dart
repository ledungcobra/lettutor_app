import 'package:flutter/material.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/screens/course_details/tabs/details.dart';
import 'package:lettutor_app/screens/course_details/tabs/pdf_file.dart';

class CourseDetails extends StatefulWidget {
  final Course course;
  int selectedIndex;

  CourseDetails({Key? key, required this.course, this.selectedIndex = 0})
      : super(key: key);

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex ?? 0;
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: const [
              Icon(Icons.details, color: Colors.black),
              Icon(Icons.picture_as_pdf, color: Colors.black)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Details(
              course: widget.course,
              selectedIndex: selectedIndex,
              changeSelectedIndex: (index) => setState(() {
                selectedIndex = index;
              }),
            ),
            PdfFile(
              url: widget.course.topics![selectedIndex].nameFile ?? '',
            )
          ],
        ),
      ),
    );
  }
}

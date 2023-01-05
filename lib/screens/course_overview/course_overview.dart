import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/course/course.dart';
import 'package:lettutor_app/screens/course_details/course_details.dart';
import 'package:lettutor_app/widgets/loading_image.dart';
import 'package:lettutor_app/widgets/button.dart';

class CourseOverview extends StatelessWidget {
  final Course course;

  CourseOverview({Key? key, required this.course}) : super(key: key);

  late BuildContext context;

  _handleDiscover() {
    Get.to(CourseDetails(
      course: course,
      selectedIndex: 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
          title: Text('Course Details', style: TextStyle(color: Colors.grey))),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _header(),
            SizedBox(height: 10),
            _courseInfo(),
          ],
        ),
      ),
    );
  }

  _header() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoadingImage(src: course.imageUrl),
            Text(course.name ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 5),
            Text(
              course.description ?? "",
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 5),
            Button(title: 'Discover', onClick: _handleDiscover)
          ],
        ),
      ),
    );
  }

  _courseInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              SizedBox(width: 18),
              Text(
                "Overview",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: const [
              Icon(
                Icons.question_mark_outlined,
                color: Colors.red,
              ),
              Text(
                'Why taking this course ?',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          Text(course.reason ?? 'Not available yet'),
          SizedBox(height: 10),
          Row(
            children: const [
              Icon(
                Icons.question_mark_outlined,
                color: Colors.red,
              ),
              Text(
                'Why taking this course ?',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          Text(course.reason ?? 'Not available yet'),
          ...courseComponent("Experience Level", Icons.work_outline,
              course.experienceLevel ?? ''),
          ...courseComponent("Course Length", Icons.timelapse,
              (course.topics?.length.toString() ?? "0") + " Topics"),
          Row(
            children: const [
              SizedBox(width: 18),
              Text(
                "Topics",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          ..._topics()
        ],
      ),
    );
  }

  courseComponent(String name, IconData icon, String value) {
    return [
      Row(
        children: [
          SizedBox(width: 18),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            icon,
            color: Colors.red,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          )
        ],
      )
    ];
  }

  _topics() {
    List<Widget> widget = [];
    for (var i = 0; i < course.topics!.length; i++) {
      var topic = course.topics![i];
      widget.add(Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${i + 1}.${topic.name}"),
              InkWell(
                onTap: () => Get.to(() => CourseDetails(
                      course: course,
                      selectedIndex: i,
                    )),
                child: Text(
                  'Find out',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ));
    }
    return widget;
  }
}

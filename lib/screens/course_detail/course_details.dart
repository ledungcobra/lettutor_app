import 'package:flutter/material.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/widgets/loading_image.dart';
import 'package:lettutor_app/widgets/button.dart';

class CourseDetails extends StatelessWidget {
  final Course course;

  CourseDetails({Key? key, required this.course}) : super(key: key);

  _handleDiscover() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Course Detail', style: TextStyle(color: Colors.grey))),
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
    for(var i = 0;i < course.topics!.length;i++){
      var topic = course.topics![i];
      widget.add( Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Text("${i + 1}.${topic.name}"),
      ));
    }
    return widget;
  }
}

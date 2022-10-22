import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/screens/course_details/controllers/course_details_controller.dart';
import 'package:lettutor_app/screens/course_details/widgets/topic_item.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/loading_image.dart';

class Details extends StatelessWidget with Dimension {
  final Course course;
  late BuildContext context;
  final void Function(int index) changeSelectedIndex;
  CourseDetailsController _courseDetailsController = Get.find();
  Details(
      {Key? key,
      required this.course,
      required this.changeSelectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return ListView(
      children: [
        LoadingImage(src: this.course.imageUrl),
        SizedBox(height: 15),
        Text(this.course.name ?? "",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        SizedBox(height: 15),
        Text(this.course.description ?? ""),
        SizedBox(height: 15),
        Text("Danh sách chủ đề",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        SizedBox(height: 15),
        Obx( ()=>_listTopic()),
      ],
    );
  }

  _listTopic() {
    List<Widget> widgets = [];
    for (int i = 0; i < course.topics!.length; i++) {
      widgets.add(TopicItem(
          topics: course.topics![i],
          position: i + 1,
          isSelected: _courseDetailsController.selectedIndex.value == i,
          changeSelectedIndex: changeSelectedIndex));
    }
    return Column(children: widgets);
  }
}

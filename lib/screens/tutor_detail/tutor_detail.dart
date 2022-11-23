import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/comment.dart';
import 'package:lettutor_app/models/tutor_detail.dart';
import 'package:lettutor_app/screens/tutor_detail/widgets/booking.dart';
import 'package:lettutor_app/screens/tutor_detail/widgets/comment_item.dart';
import 'package:lettutor_app/screens/tutor_detail/widgets/course_preview_button.dart';
import 'package:lettutor_app/screens/tutor_detail/widgets/text_and_chips.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/button.dart';
import 'package:lettutor_app/widgets/title_button.dart';

import '../../dto/ResponseEntity.dart';

class TutorDetailScreen extends StatelessWidget with Dimension {
  var courseExpanded = true.obs;
  var commentExpanded = true.obs;
  final TutorDetail tutorDetail;
  final _tutorService = Get.find<TutorService>();
  late BuildContext context;

  TutorDetailScreen({super.key, required this.tutorDetail});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text('Tutor Detail'),
        ),
        floatingActionButton: IconButton(
            iconSize: 50,
            onPressed: () {},
            icon: Icon(Icons.schedule_rounded, color: PRIMARY_COLOR)),
        backgroundColor: Colors.white70,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    _header(),
                    SizedBox(
                      height: 20,
                    ),
                    _actions(),
                    SizedBox(
                      height: 20,
                    ),
                    _body(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _header() {
    return Row(
      children: [
        NetworkAvatar(
          url: tutorDetail.user?.avatar,
          width: 80,
          height: 80,
        ),
        Column(
          children: [
            Text(tutorDetail.user?.name ?? ""),
            _stars(tutorDetail.avgRating?.toInt() ?? 0),
            Align(
                child: Container(
              height: 1.2,
              width: 120,
              color: Colors.greenAccent,
              alignment: AlignmentDirectional.centerStart,
            ))
          ],
        )
      ],
    );
  }

  Widget _stars(int count) {
    List<Widget> stars = [];
    for (var i = 0; i < count; i++) {
      stars.add(Icon(
        Icons.star,
        color: Colors.amber,
      ));
    }
    return Row(
      children: stars,
    );
  }

  _actions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleButton(
                title: 'Message',
                icon: Icons.message_outlined,
                onPress: _onPressMessageNow),
            TitleButton(
                title: 'Favorite',
                icon: Icons.favorite_outline,
                onPress: _onPressFavorite),
            TitleButton(
                title: 'Report',
                icon: Icons.info_outline,
                onPress: _onPressReport),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Button(
            onClick: () =>
                Booking.showFullModal(context, tutorDetail.user!.id!),
            title: 'Book')
      ],
    );
  }

  void _onPressMessageNow() {
    Get.defaultDialog(
        title: 'Compose message',
        radius: 2,
        middleText: "",
        content: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter some thing ...'),
            )
          ],
        ),
        actions: [
          Button(
              title: 'Send',
              onClick: () {
                Get.back();
                Get.snackbar('Sending', 'Message is sending',
                    backgroundColor: Colors.green);
              })
        ]);
  }

  Widget _body() {
    var gap = SizedBox(height: 10);
    var halfGap = SizedBox(height: 5);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tutorDetail.bio!,
          style: TextStyle(fontSize: 18),
        ),
        gap,
        TextAndChips(text: 'Language', chips: tutorDetail.getSpecialties()),
        halfGap,
        Text(
          "Interest",
          style: const TextStyle(fontSize: 16, color: PRIMARY_COLOR),
        ),
        halfGap,
        Text(
          tutorDetail.interests!,
          style: TextStyle(fontSize: 18),
        ),
        gap,
        Text(
          "Teaching Experience",
          style: const TextStyle(fontSize: 16, color: PRIMARY_COLOR),
        ),
        halfGap,
        Text(
          tutorDetail.experience!,
          style: TextStyle(fontSize: 18),
        ),
        gap,
        TextAndChips(text: 'Specialties', chips: tutorDetail.getSpecialties()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Courses",
              style: const TextStyle(fontSize: 16, color: PRIMARY_COLOR),
            ),
            TextButton(
              onPressed: () {
                courseExpanded.value = !courseExpanded.value;
              },
              child:
                  Obx(() => Text(courseExpanded.value ? 'Collapse' : 'Expand')),
            )
          ],
        ),
        Obx(
          () {
            if (courseExpanded.value) {
              return Column(
                children: tutorDetail
                    .getCourses()
                    .map(
                      (course) => CoursePreviewButton(coursePreview: course),
                    )
                    .toList(),
              );
            } else {
              return Container();
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Comments",
              style: const TextStyle(fontSize: 16, color: PRIMARY_COLOR),
            ),
            TextButton(
              onPressed: () {
                commentExpanded.value = !commentExpanded.value;
              },
              child: Obx(
                  () => Text(commentExpanded.value ? 'Collapse' : 'Expand')),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          color: Colors.grey,
          height: 2,
        ),
        SizedBox(
          height: 20,
        ),
        Obx(() {
          if (commentExpanded.value) {
            return _comments();
          }
          return Container();
        })
      ],
    );
  }

  _comments() {
    return FutureBuilder(
      future: _tutorService.getFeedbacksPaging(tutorDetail.user!.id!, 1, 12),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.hasData) {
          var response = snapshot.data as ResponseEntity<List<Comment>>;

          return SizedBox(
            height: Get.height / 2,
            child: ListView.builder(
              itemCount: response.data!.length,
              itemBuilder: (context, index) {
                var comment = response.data![index];
                return CommentItem(comment: comment);
              },
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  void _onPressFavorite() {}

  void _onPressReport() {
    Get.snackbar('Reporting', 'Sending report to admin',
        backgroundColor: Colors.red);
  }
}

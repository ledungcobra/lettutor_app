import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/comment/comment.dart';
import 'package:lettutor_app/models/tutor_detail/tutor_detail.dart';
import 'package:lettutor_app/screens/tutor_detail/widgets/schedule_list.dart';
import 'package:lettutor_app/screens/tutor_detail/widgets/comment_item.dart';
import 'package:lettutor_app/screens/tutor_detail/widgets/course_preview_button.dart';
import 'package:lettutor_app/screens/tutor_detail/widgets/text_and_chips.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/button.dart';
import 'package:lettutor_app/widgets/title_button.dart';

import '../../models/response_entity.dart';
import '../../services/course_service.dart';
import '../course_overview/course_overview.dart';
import '../home/home_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class TutorDetailScreen extends StatelessWidget with Dimension, HandleUIError {
  var courseExpanded = true.obs;
  var commentExpanded = true.obs;
  final _tutorDetail = TutorDetail().obs;
  final coursesService = Get.find<CourseService>();
  final _tutorService = Get.find<TutorService>();
  final String tutorId;
  String? name;
  HomeController get homeController => Get.find<HomeController>();

  TutorDetailScreen(
      {super.key, required tutorDetail, required this.tutorId, this.name}) {
    _tutorDetail.value = tutorDetail;
  }

  TutorDetail get tutorDetail => _tutorDetail.value;

  @override
  Widget build(BuildContext context) {

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
            Text(name ?? ""),
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
            Obx(() {
              return TitleButton(
                  title: 'Favorite',
                  icon: _tutorDetail.value.isFavorite!
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  onPress: () async => _onPressFavorite());
            }),
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
            onClick: () => ScheduleList.showFullModal(Get.context!, tutorId),
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
        TextAndChips(text: 'Languages', chips: tutorDetail.getLanguages()),
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
                      (course) => CoursePreviewButton(
                        coursePreview: course,
                        onClick: () => openCourse(course.id),
                      ),
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
      future:
          _tutorService.getFeedbacksPaging(tutorDetail.user?.id ?? "", 1, 12),
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

  void _onPressFavorite() async {
    _tutorDetail.value.isFavorite = !_tutorDetail.value.isFavorite!;
    _tutorDetail.value = TutorDetail.fromJson(_tutorDetail.value.toJson());
    var response = await _tutorService.performLike(tutorDetail.user?.id ?? "");
    homeController.updateLikeFor(tutorDetail.user?.id ?? "");
    if (response.hasError) {
      return handleError(response.error!);
    }
  }

  void _onPressReport() {
    Get.snackbar('Reporting', 'Sending report to admin',
        backgroundColor: Colors.red);
  }

  openCourse(String? id) async {
    var response = await coursesService.getCourseDetail(id!);
    if (response.hasError) {
      handleError(response.error!);
      return;
    }
    Get.to(CourseOverview(course: response.data!));
  }
}

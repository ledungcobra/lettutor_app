import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/home_model.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/models/user_info.dart';
import 'package:lettutor_app/screens/home/home_controller.dart';
import 'package:lettutor_app/screens/home/widgets/upcoming_lesson.dart';
import 'package:lettutor_app/screens/home/widgets/user_info_drawer.dart';
import 'package:lettutor_app/screens/tutor_detail/tutor_detail.dart';
import 'package:lettutor_app/screens/tutors/widgets/tutor_card.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/center_error.dart';
import 'package:lettutor_app/widgets/loading.dart';

class HomeScreen extends GetView<HomeController> {
  late BuildContext context;
  final UserService _userService = Get.find();
  final TutorService _tutorService = Get.find();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        endDrawer: UserInfoDrawer(),
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            FutureBuilder(
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.hasData) {
                  var userData = snapshot.data as UserInfo;
                  return InkWell(
                    onTap: () => Scaffold.of(context).openEndDrawer(),
                    child: NetworkAvatar(
                      height: 40,
                      width: 40,
                      url: userData.user!.avatar!,
                    ),
                  );
                }
                return CircularProgressIndicator();
              }),
              future: _userService.getUserInfo(),
            )
          ],
        ),
        body: Obx(() =>
            _homeBody(controller.header.value, controller.listTutors.value)));
  }

  Widget _homeBody(Header? header, List<Tutor> listTutors) {
    return ListView(children: [
      if (header != null) UpCommingLession(header),
      _recommendTutors(listTutors)
    ]);
  }

  void _handleShowTutorDetail(Tutor tutor) async {
    var tutorDetail = await _tutorService.getTutorDetail(tutor.userId!);
    Get.to(TutorDetailScreen(tutorDetail: tutorDetail));
  }

  _recommendTutors(List<Tutor> recommendTutors) {
    return Column(
      children: recommendTutors
          .map((tutor) => TutorCard(
              tutor: tutor, onClick: () => _handleShowTutorDetail(tutor)))
          .toList(),
    );
  }
}

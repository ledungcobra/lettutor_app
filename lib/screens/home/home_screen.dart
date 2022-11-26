import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../dto/ResponseEntity.dart';
import '../../utils/mixing.dart';
import '../../widgets/load_more_footer.dart';
import 'widgets/no_upcoming_lesson.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with HandleUIError {
  final UserService _userService = Get.find();
  final TutorService _tutorService = Get.find();
  final controller = Get.find<HomeController>();
  final GlobalKey contentKey = GlobalKey();
  final GlobalKey refresherKey = GlobalKey();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final listViewController = ScrollController();
  final showHeader = true.obs;

  void findTutorById(String tutorId) {}

  @override
  void initState() {
    listViewController.addListener(() {
      if (listViewController.offset >
              listViewController.position.minScrollExtent &&
          !listViewController.position.outOfRange) {
        showHeader.value = false;
      } else {
        showHeader.value = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                var response = snapshot.data as ResponseEntity<UserInfo?>;
                if (response.hasError) {
                  handleError(response.error!);
                  return Container();
                }
                return InkWell(
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                  child: NetworkAvatar(
                    height: 30,
                    width: 55,
                    url: response.data!.user!.avatar!,
                  ),
                );
              }
              return CircularProgressIndicator();
            }),
            future: _userService.getUserInfo(),
          )
        ],
      ),
      body: _homeBody(),
    );
  }

  Widget _homeBody() {
    return SizedBox(
      height: Get.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Obx(() {
            if (showHeader.isFalse) {
              return SizedBox.shrink();
            }
            if (controller.header.value != null) {
              return UpCommingLession(
                  controller.header.value!, controller.totalTime.value);
            }
            return NoUpcomingLesson(
              totalTime: controller.totalTime.value,
            );
          }),
          _recommendTutors()
        ],
      ),
    );
  }

  void _handleShowTutorDetail(Tutor tutor) async {
    var response = await _tutorService.getTutorDetail(tutor.userId!);
    if (response.hasError) {
      handleError(response.error!);
      return;
    }
    Get.to(TutorDetailScreen(
      tutorDetail: response.data!,
      tutorId: tutor.userId!,
    ));
  }

  _recommendTutors() {
    return Expanded(
      child: _refreshItem(),
    );
  }

  _refreshItem() {
    return SmartRefresher(
      key: refresherKey,
      enablePullUp: true,
      enablePullDown: true,
      header: WaterDropHeader(),
      footer: LoadMoreFooter(),
      controller: refreshController,
      onLoading: () async {
        await controller.loadNextTutors();
        if (mounted) {
          setState(() {});
        }
        refreshController.loadComplete();
      },
      onRefresh: () async {
        await controller.refreshTutors();
        if (mounted) {
          setState(() {});
        }
        refreshController.refreshCompleted();
      },
      child: ListView.builder(
        controller: listViewController,
        key: contentKey,
        itemCount: controller.listTutors.length,
        itemBuilder: (context, index) => TutorCard(
          key: ObjectKey(controller.listTutors[index]),
          tutor: controller.listTutors[index],
          onClick: () => _handleShowTutorDetail(controller.listTutors[index]),
          likable: controller,
        ),
      ),
    );
  }
}

import 'package:floating_chat_button/floating_chat_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/models/user_info/user_info.dart';
import 'package:lettutor_app/screens/home/home_controller.dart';
import 'package:lettutor_app/screens/home/widgets/upcoming_lesson.dart';
import 'package:lettutor_app/screens/tutor_detail/tutor_detail.dart';
import 'package:lettutor_app/screens/tutors/widgets/tutor_card.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/response_entity.dart';
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

  get controller => Get.find<HomeController>();
  final GlobalKey contentKey = GlobalKey();
  final GlobalKey refresherKey = GlobalKey();

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final listViewController = ScrollController();
  final showHeader = true.obs;

  void findTutorById(String tutorId) {}

  @override
  void initState() {
    Get.put(HomeController());
    controller.init();
    listViewController.addListener(() {
      if (listViewController.offset >
              listViewController.position.minScrollExtent + 20 &&
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
                    url: response.data?.user?.avatar ?? "",
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
    Get.to(
      () => TutorDetailScreen(
        tutorDetail: response.data!,
        tutorId: tutor.userId!,
        name: tutor.name
      ),
    );
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
        refreshController.loadComplete();
        if (mounted) {
          setState(() {});
        }
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

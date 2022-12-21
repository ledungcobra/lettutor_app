import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/course_overview/course_overview.dart';
import 'package:lettutor_app/screens/courses/widgets/course_item.dart';
import 'package:lettutor_app/services/course_service.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/course.dart';
import '../../../widgets/load_more_footer.dart';
import 'courses_controller.dart';

class CoursesTab extends StatefulWidget {
  CoursesTab({Key? key}) : super(key: key);

  @override
  State<CoursesTab> createState() => _CoursesTabState();
}

class _CoursesTabState extends State<CoursesTab> with HandleUIError {
  final GlobalKey _contentKey = GlobalKey();
  final GlobalKey _refresherKey = GlobalKey();
  final coursesService = Get.find<CourseService>();

  CoursesController get controller => Get.find<CoursesController>();
  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  void initState() {
    Get.put(CoursesController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      key: _refresherKey,
      enablePullUp: true,
      header: WaterDropHeader(),
      physics: BouncingScrollPhysics(),
      footer: LoadMoreFooter(),
      controller: refreshController,
      onRefresh: () async {
        await controller.loadCourses();
        if (mounted) {
          setState(() {});
        }
        refreshController.refreshCompleted();
      },
      onLoading: () async {
        await controller.loadCourses();
        if (mounted) {
          setState(() {});
        }
        refreshController.loadComplete();
      },
      child: ListView.builder(
        key: _contentKey,
        itemCount: controller.courses.length,
        itemBuilder: (context, index) => CourseItem(
          course: controller.courses[index],
          onTap: () async {
            await _loadCourse(controller.courses[index]);
          },
        ),
      ),
    );
  }

  _loadCourse(Course course) async {
    if (course.id == null) {
      Get.snackbar("Error", 'Invalid course',
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }
    var response = await coursesService.getCourseDetail(course.id!);
    if (response.hasError) {
      handleError(response.error!);
      return;
    }
    Get.to(CourseOverview(course: response.data!));
  }
}

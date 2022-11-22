import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/course_overview/course_overview.dart';
import 'package:lettutor_app/screens/courses/widgets/course_item.dart';
import 'package:lettutor_app/services/course_service.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/course.dart';

class CoursesTab extends StatefulWidget {
  CoursesTab({Key? key}) : super(key: key);

  @override
  State<CoursesTab> createState() => _CoursesTabState();
}

class _CoursesTabState extends State<CoursesTab> with HandleUIError {
  final coursesService = Get.find<CourseService>();
  final GlobalKey _contentKey = GlobalKey();
  final GlobalKey _refresherKey = GlobalKey();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int page = 1;
  int perPage = 2;
  var courses = <Course>[];


  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  loadCourses() async {
    print('Current page=$page size=$perPage');
    await Future.delayed(const Duration(milliseconds: 500));
    var r = await coursesService.getCoursesPagination(page, perPage);
    if (r.hasError) {
      handleError(r.error!);
      setState(() {});
      return;
    }
    courses.addAll(r.data!);
    if (mounted) {
      setState(() {});
    }
    refreshController.loadComplete();
    page++;
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        key: _refresherKey,
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        physics: BouncingScrollPhysics(),
        footer: CustomFooter(
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return SizedBox(
              height: 50.0,
              child: Center(child: body),
            );
          },
        ),
        controller: refreshController,
        onLoading: () async {
          await loadCourses();
        },
        child: ListView.builder(
          key: _contentKey,
          itemCount: courses.length,
          itemBuilder: (context, index) => CourseItem(
            course: courses[index],
            onTap: () => Get.to(
              CourseOverview(course: courses[index]),
            ),
          ),
        ));
  }
}

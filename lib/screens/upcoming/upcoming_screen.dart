import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/upcoming/widgets/upcomming_item.dart';
import 'package:lettutor_app/widgets/not_found.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/class_history/class_history.dart';
import '../../widgets/load_more_footer.dart';
import 'upcoming_controller.dart';

class UpcomingScreen extends StatefulWidget {
  UpcomingScreen({Key? key}) : super(key: key) {}

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {

  final controller = Get.find<UpcomingController>();

  Timer? timer;
  final elapsedTime = 0.obs;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final GlobalKey refresherKey = GlobalKey();

  @override
  void initState() {
    Get.put(UpcomingController(setState));
    controller.loadNextUpcoming();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upcoming')),
      backgroundColor: Colors.grey[200],
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: _listSchedule(),
        ),
      ),
    );
  }

  Widget _listSchedule() {
    return SmartRefresher(
      key: refresherKey,
      enablePullUp: true,
      enablePullDown: true,
      header: WaterDropHeader(),
      footer: LoadMoreFooter(),
      controller: refreshController,
      onLoading: () async {
        await controller.loadNextUpcoming();
        refreshController.loadComplete();
        if (mounted) {
          setState(() {});
        }
      },
      onRefresh: () async {
        await controller.refreshUpcoming();
        if (mounted) {
          setState(() {});
        }
        refreshController.refreshCompleted();
      },
      child: listBookingItems(controller.bookingItems),
    );
  }

  listBookingItems(List<ClassHistory> upComings) {
    return upComings.isEmpty
        ? Row(
            children: const [
              NotFound(),
            ],
          )
        : ListView(
            children: upComings
                .map((item) => UpcomingItem(
                      bookingItem: item,
                    ))
                .toList(),
          );
  }
}

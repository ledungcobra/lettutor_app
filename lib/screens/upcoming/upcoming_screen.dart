import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/upcoming/widgets/upcomming_item.dart';
import 'package:lettutor_app/widgets/not_found.dart';

import '../../widgets/loading.dart';
import 'upcoming_controller.dart';

class UpcomingScreen extends StatefulWidget {
  UpcomingScreen({Key? key}) : super(key: key) {}

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  final upcomingController = Get.find<UpcomingController>();
  Timer? timer;
  final elapsedTime = 0.obs;

  @override
  void initState() {
    upcomingController.loadData();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedTime.value = elapsedTime.value + 1;
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
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
    return Obx(
        () => upcomingController.bookingItems.isEmpty && elapsedTime.value <= 8
            ? Loading()
            : upcomingController.bookingItems.isEmpty
                ? Row(
                    children: [
                      NotFound(),
                    ],
                  )
                : ListView(
                    key: UniqueKey(),
                    children: upcomingController.bookingItems
                        .map((item) => UpcomingItem(
                              key: UniqueKey(),
                              bookingItem: item,
                            ))
                        .toList(),
                  ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/upcoming/widgets/upcomming_item.dart';

import '../../widgets/loading.dart';
import 'upcoming_controller.dart';

class UpcomingScreen extends StatefulWidget {
  UpcomingScreen({Key? key}) : super(key: key) {}

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  final upcomingController = Get.find<UpcomingController>();

  @override
  void initState() {
    super.initState();
    upcomingController.loadData();
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
    return Obx(() => upcomingController.bookingItems.isEmpty
        ? Loading()
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

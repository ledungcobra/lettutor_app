import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';

class NoUpcomingLesson extends StatelessWidget {
  final int totalTime;

  const NoUpcomingLesson({super.key, required this.totalTime});

  @override
  Widget build(BuildContext context) {
    var duration = Duration(minutes: totalTime);
    return Container(
      width: double.infinity,
      height: Get.height * 0.18,
      color: Get.theme.primaryColorDark,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Text(
              'You have no upcoming lesson.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            SizedBox(height: 10),
            Text('Total lesson time is ${duration.inHours} hours ${duration.inMinutes - duration.inHours * 60} minutes', style: TextStyle(color: Colors.white, fontSize: 18),)
          ],
        ),
      ),
    );
  }
}
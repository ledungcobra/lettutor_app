import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_app/screens/video_call/jitsy_util.dart';
import 'package:lettutor_app/screens/video_call/video_call_screen.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/button.dart';

import '../../../models/booking_item.dart';

class UpCommingLession extends StatefulWidget {
  BookingItem header;
  final int totalTime;
  UpCommingLession(this.header, this.totalTime);

  @override
  State<UpCommingLession> createState() => _UpCommingLessionState();
}

class _UpCommingLessionState extends State<UpCommingLession> {
  final dateFormatter = Get.find<DateFormat>();
  late Timer timer;
  String remainingTimeText = "";

  DateTime get startDate => DateTime.fromMillisecondsSinceEpoch(
      widget.header!.scheduleDetailInfo!.startPeriodTimestamp!);

  DateTime get endDate => DateTime.fromMillisecondsSinceEpoch(
      widget.header!.scheduleDetailInfo!.endPeriodTimestamp!);

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTimeText =
            'Remaining ${startDate.difference(DateTime.now()).print()}';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var textWhiteStyle = TextStyle(color: Colors.white, fontSize: 25);
    final duration = Duration(minutes: widget.totalTime);

    return Container(
      width: double.infinity,
      height: Get.height * 0.35,
      color: Get.theme.primaryColorDark,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            Text(
              '${dateFormatter.format(startDate)} - ${endDate.hour}:${endDate.minute}',
              style: textWhiteStyle,
            ),
            Text(
              remainingTimeText,
              style: TextStyle(color: Colors.yellow),
            ),
            SizedBox(height: 10),
            Text('Total lesson time is ${duration.inHours} hours ${duration.inMinutes - duration.inHours * 60} minutes', style: Get.isDarkMode ? Get.theme.textTheme.button: TextStyle(color: Colors.white, fontSize: 16)),
            Button(
              title: 'Enter lesson room',
              onClick: ()  async {
                await joinMeetingJitsi(widget.header);
              },
              color: Get.isDarkMode ? Get.theme.backgroundColor: Colors.white,
              textColor: Get.theme.primaryColor,
              full: false,
              radius: 20,
            )
          ],
        ),
      ),
    );
  }
}

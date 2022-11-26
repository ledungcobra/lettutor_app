import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/button.dart';

import '../../../models/schedule_info.dart';
import '../../../services/tutor_service.dart';
import '../../../widgets/loading.dart';
import 'booking_dialog.dart';

class ScheduleList with HandleUIError {
  late String tutorId;
  final tutorService = Get.find<TutorService>();
  final scheduleInfos = <TutorScheduleInfo>[].obs;

  ScheduleList.showFullModal(BuildContext context, String tutorId) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Booking",
      transitionDuration: Duration(milliseconds: 2),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                "Booking",
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Overpass',
                    fontSize: 20),
              ),
              elevation: 0.0),
          backgroundColor: Colors.white.withOpacity(0.90),
          body: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: const Color(0xfff8f8f8),
                  width: 1,
                ),
              ),
            ),
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var response = snapshot.data!;
                  if (response.hasError) {
                    handleError(response.error!);
                    return SizedBox.shrink();
                  }
                  scheduleInfos.value = response.data!;
                  return _listSchedule();
                }
                return Loading();
              },
              future: tutorService.getTutorSchedules(tutorId),
            ),
          ),
        );
      },
    );
  }

  _listSchedule() {
    return Obx(
        ()=> ListView(
        children: scheduleInfos.map((schedule) {
          return Button(
            color: schedule.isBooked! ? Colors.grey : PRIMARY_COLOR,
            title:
                '${schedule.startTime} - ${schedule.endTime}     ${DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp ?? 0))}',
            onClick: () async => await _handleBooking(schedule),
          );
        }).toList(),
      ),
    );
  }

  _handleBooking(TutorScheduleInfo schedule) async {
    if(schedule.isBooked!){
      Get.snackbar('Error', 'Class is booked', colorText: Colors.white, backgroundColor: Colors.red,snackPosition: SnackPosition.BOTTOM);
      return;
    }
    var booked =  await Get.dialog(BookingDialog(schedule: schedule));
    if(booked){
      schedule.isBooked = true;
      scheduleInfos.refresh();
    }
  }
}

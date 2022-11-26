import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/services/tutor_service.dart';

import '../../../models/schedule_info.dart';

class BookingDialog extends StatelessWidget {
  TutorScheduleInfo schedule;
  final tutorService = Get.find<TutorService>();

  BookingDialog({super.key, required this.schedule});

  final reportText = "".obs;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: Get.height * 0.4,
        width: Get.width * 1,
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Text('Booking Dialog',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 25),
            SizedBox(height: 20),
            SizedBox(
              width: Get.width * 0.85,
              child: Card(
                borderOnForeground: true,
                color: Colors.white,
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 8, //or null
                    decoration: InputDecoration.collapsed(
                        hintText: "Enter your note here"),
                    onChanged: (value) => reportText.value = value,
                    onSubmitted: (value) => reportText.value = value,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Get.back(result: false),
        ),
        ElevatedButton(onPressed: _handleSend, child: Text('Send'))
      ],
    );
  }

  _handleSend() async {
    List<String> detailIds = schedule.scheduleDetails?.map((e) => e.id!)
        .toList() ?? [];
    var success = await tutorService.bookAClass(
        detailIds
        ,
        reportText.value);
    if (success) {
      Get.back(result: true);
      Get.snackbar(
        'Success',
        'Rating tutor success',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.back(result: false);
      Get.snackbar(
        'Error',
        'Error when rating tutor',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

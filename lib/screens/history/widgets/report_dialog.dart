import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/class_history/class_history.dart';
import 'package:lettutor_app/services/tutor_service.dart';

import '../../../models/class_history/tutor_info.dart';
import '../../../utils/constants.dart';

class ReportDialog extends StatelessWidget {
  final ClassHistory history;
  final tutorService = Get.find<TutorService>();

  ReportDialog({super.key, required this.history});

  TutorInfo get tutorInfo =>
      history.scheduleDetailInfo!.scheduleInfo!.tutorInfo!;

  final selectedReason = reportReason.first.obs;
  final reportText = ''.obs;

  _handleSendReport() async {
    if (selectedReason.value.id == 0) {
      Get.snackbar(
        'Error',
        'Please select reason',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    var success = await tutorService.saveReport(reportText.value,
        history!.classReview!.bookingId!, selectedReason.value.id);
    Get.back();
    if (success) {
      Get.snackbar(
        'Success',
        'Reported to the tutor',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Error to report this tutor',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: Get.height * 0.4,
        width: Get.width * 1,
        child: ListView(
          shrinkWrap: true,
          children: [
            RichText(
              text: TextSpan(children: const [
                TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                TextSpan(
                    text: ' Reason you report this lesson',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ]),
            ),
            SizedBox(
              width: Get.width * 0.85,
              child: Obx(
                () => DropdownButton<String>(
                  icon: SizedBox.shrink(),
                  value: selectedReason.value.description,
                  items: reportReason.map((r) => r.description).map((r) {
                    return DropdownMenuItem<String>(
                      value: r,
                      child: Text(r),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedReason.value = reportReason
                        .firstWhere((reason) => reason.description == value);
                  },
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.85,
              child: Card(
                borderOnForeground: true,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 8, //or null
                    decoration: InputDecoration.collapsed(
                        hintText: "Enter your text here"),
                    onChanged: (value) => reportText.value = value,
                    onSubmitted: (value) => reportText.value = value,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Get.back(),
        ),
        ElevatedButton(onPressed: _handleSendReport, child: Text('Send'))
      ],
    );
  }
}

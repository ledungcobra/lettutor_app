import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/class_history/class_history.dart';
import 'package:lettutor_app/services/tutor_service.dart';

import '../../../models/booking_item/booking_item.dart';
import '../../../utils/constants.dart';
import '../upcoming_controller.dart';

class CancelDialog extends StatelessWidget {
  final BookingItem bookingItem;
  final tutorService = Get.find<TutorService>();
  final controller = Get.find<UpcomingController>();

  CancelDialog({super.key, required this.bookingItem});

  final selectedReason = cancelReason.first.obs;
  final reportText = ''.obs;

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
                    text: ' What was the reason you cancel this booking?',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ]),
            ),
            SizedBox(
              width: Get.width * 0.85,
              child: Obx(
                () => DropdownButton<String>(
                  icon: SizedBox.shrink(),
                  value: selectedReason.value.description,
                  items: cancelReason.map((r) => r.description).map((r) {
                    return DropdownMenuItem<String>(
                      value: r,
                      child: Text(r),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedReason.value = cancelReason
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
                    decoration:
                        InputDecoration.collapsed(hintText: "Additional Notes"),
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
          onPressed: () => Get.back(result: false),
        ),
        ElevatedButton(
            onPressed: () => controller.handleCancel(
                reportText.value, bookingItem, selectedReason.value.id),
            child: Text('Cancel'))
      ],
    );
  }
}

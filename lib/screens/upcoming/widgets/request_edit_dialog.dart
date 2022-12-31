import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/services/tutor_service.dart';

import '../../../models/booking_item/booking_item.dart';
import '../upcoming_controller.dart';

class RequestEditDialog extends StatelessWidget {
  final BookingItem bookingItem;
  final tutorService = Get.find<TutorService>();
  final upcomingController = Get.find<UpcomingController>();

  RequestEditDialog({super.key, required this.bookingItem});

  final reportText = "".obs;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = bookingItem.studentRequest ?? "";
    return AlertDialog(
      content: SizedBox(
        height: Get.height * 0.3,
        width: Get.width * 1,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text('Special request'),
            SizedBox(height: 15),
            RichText(
              text: TextSpan(children: const [
                TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                TextSpan(
                    text: ' Note',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ]),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: Get.width * 0.85,
              child: Card(
                borderOnForeground: true,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    maxLines: 8,
                    //or null
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
        ElevatedButton(
            onPressed: () async  => await upcomingController.handleUpdateRequest(
                reportText.value, bookingItem),
            child: Text('Send'))
      ],
    );
  }
}

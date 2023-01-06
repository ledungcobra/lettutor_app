import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/class_history/class_history.dart';
import '../../../models/class_history/class_review.dart';
import '../../../models/class_history/tutor_info.dart';
import '../../../services/tutor_service.dart';
import '../../../widgets/stars.dart';

class RatingTutorDialog extends StatelessWidget {
  final ClassHistory history;
  final star = 0.obs;
  final reportText = "".obs;
  final tutorService = Get.find<TutorService>();

  RatingTutorDialog({super.key, required this.history});

  TutorInfo get tutorInfo =>
      history!.scheduleDetailInfo!.scheduleInfo!.tutorInfo!;

  ClassReview? get reviews => history.classReview;

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
              child: Text('Rating Dialog',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 25),
            Center(child: Text('You are rating for ${tutorInfo.name}?')),
            SizedBox(height: 20),
            Obx(
              () => Stars(
                starCount: 5,
                rating: star.value.toDouble(),
                onRatingChanged: _handleStartChange,
              ),
            ),
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
                        hintText: "Enter your text here"),
                    onChanged: (value) => reportText.value = value,
                    onSubmitted: (value)=> reportText.value = value,
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
          onPressed: () => Get.back(),
        ),
        ElevatedButton(onPressed: _handleSend, child: Text('Send'))
      ],
    );
  }

  _handleSend() async {
    var success = await tutorService.ratingTutor(
        reportText.value, star.value, tutorInfo.id!, history.id!);
    Get.back();
    if (success) {
      Get.snackbar(
        'Success',
        'Rating tutor success',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Error when rating tutor',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  _handleStartChange(double value) {
    star.value = value.ceil();
  }
}

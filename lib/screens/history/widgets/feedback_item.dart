import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/class_history/feedback.dart' as f;
import '../../../widgets/stars.dart';

class FeedbackItem extends StatelessWidget {
  final f.Feedback feedback;

  const FeedbackItem({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: !Get.isDarkMode? Colors.white: Colors.white24,),
      height: 50,
      width: Get.width,
      child: Row(
        children: [
          Text('Rating'),
          SizedBox(
            width: 10,
          ),
          Stars(
            rating: feedback.rating?.toDouble() ?? 0,
            starCount: 5,
            onRatingChanged: (double rating) {},
          ),
          SizedBox(
            width: 10,
          ),
          Text((feedback.content ?? "").isEmpty
              ? "Not available"
              : feedback.content!)
        ],
      ),
    );
  }
}

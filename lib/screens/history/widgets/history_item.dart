import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/services/utils_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/avatar.dart';

import '../../../models/class_history/class_history.dart';
import '../../../models/class_history/class_review.dart';
import '../../../widgets/divider.dart';
import '../../../widgets/stars.dart';
import 'feedback_item.dart';
import 'rating_tutor_dialog.dart';
import 'report_dialog.dart';

class HistoryItem extends StatelessWidget with Dimension {
  final ClassHistory history;
  final utilService = Get.find<UtilService>();

  HistoryItem({Key? key, required this.history}) : super(key: key);

  String get session =>
      '${timeStart.hour}:${timeStart.minute} - ${timeEnd.hour}:${timeEnd.minute}';

  get timeStart => DateTime.fromMillisecondsSinceEpoch(
      history.scheduleDetailInfo!.startPeriodTimestamp!);

  get timeEnd => DateTime.fromMillisecondsSinceEpoch(
      history.scheduleDetailInfo!.endPeriodTimestamp!);

  ClassReview? get reviews => history.classReview;

  _messageNow() {}

  @override
  Widget build(BuildContext context) {
    var tutor = history.scheduleDetailInfo?.scheduleInfo?.tutorInfo!;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: !Get.isDarkMode ? Colors.white : Colors.white24,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Lesson time $session'),
              Row(
                children: [
                  Text(utilService.languages[tutor!.country]?.description
                          ?.toString() ??
                      ""),
                  IconButton(
                    onPressed: _messageNow,
                    icon: Icon(
                      Icons.message_outlined,
                      color: !Get.isDarkMode ? PRIMARY_COLOR : Colors.white24,
                    ),
                  ),
                  NetworkAvatar(url: tutor.avatar),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        SizedBox(height: 2),
        Container(
          decoration: BoxDecoration(
            color: !Get.isDarkMode ? Colors.white : Colors.white24,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(history.studentRequest ?? 'No request for lesson'),
              SizedBox(
                height: 10,
              ),
              Container(height: 1, width: double.infinity, color: Colors.grey),
              _tutorReview(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: _handleOpenRating,
                      child: Text('Add a Rating')),
                  TextButton(
                      onPressed: _handleOpenReport, child: Text('Report')),
                ],
              )
            ],
          ),
        ),
        Container(height: 1, width: double.infinity, color: Colors.blueAccent),
        SizedBox(height: 2),
        _feedbacks(),
        SizedBox(height: 40),
      ],
    );
  }

  _handleOpenRating() {
    Get.dialog(RatingTutorDialog(history: history));
  }

  _handleOpenReport() {
    Get.dialog(ReportDialog(
      history: history,
    ));
  }

  Widget _tutorReview() {
    if (reviews == null) {
      return Text('Tutor haven\'t reviewed yet');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Review from tutor'),
        SizedBox(
          height: 10,
        ),
        Text(
          'Session $session',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Lesson status: ${reviews?.lessonStatus?.status?.toString()}'),
        Text('Book: ${reviews?.book}-${reviews?.unit}-${reviews?.lesson}'),
        if (reviews?.lessonProgress != null &&
            reviews!.lessonProgress!.isNotEmpty)
          Text('Lesson progress ${reviews?.lessonProgress}'),
        _skillRating('Behaviour', reviews?.behaviorRating?.toInt() ?? 0,
            reviews?.behaviorComment),
        _skillRating('Listening', reviews?.listeningRating?.toInt() ?? 0,
            reviews?.listeningComment),
        _skillRating('Speaking', reviews?.speakingRating?.toInt() ?? 0,
            reviews?.speakingComment),
        _skillRating('Vocabulary ', reviews?.vocabularyRating?.toInt() ?? 0,
            reviews?.behaviorComment),
        Text('Overall comment: ${reviews?.overallComment?.toString() ?? ""}'),
        SizedBox(height: 10),
        Container(height: 1, width: double.infinity, color: Colors.grey),
      ],
    );
  }

  Widget _skillRating(String? skill, int? start, String? comment) {
    if (start == null || comment == null) {
      return SizedBox.shrink();
    }
    return Row(
      children: [
        Text(skill ?? ""),
        Stars(
          onRatingChanged: (v) {},
          rating: (start ?? 0).toDouble(),
        ),
        Text(comment ?? "")
      ],
    );
  }

  _feedbacks() {
    if (history.feedbacks == null || history.feedbacks!.isEmpty) {
      return SizedBox.shrink();
    }
    var feedbacks = history.feedbacks!;
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            FeedbackItem(key: UniqueKey(), feedback: feedbacks[index]),
        separatorBuilder: (context, index) => MyDivider(),
        itemCount: feedbacks.length);
  }
}

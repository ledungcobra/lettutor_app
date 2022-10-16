import 'package:flutter/material.dart';
import 'package:lettutor_app/models/history/History.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/stars.dart';

class HistoryItem extends StatelessWidget with Dimension {
  final History history;

  const HistoryItem({Key? key, required this.history}) : super(key: key);

  _messageNow() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Lession time ${history.lessonDetail!.start!} - ${history.lessonDetail!.end!}'),
              Row(
                children: [
                  Text(history.teacherInfo!.nationality!),
                  IconButton(
                      onPressed: _messageNow,
                      icon: Icon(Icons.message_outlined, color: PRIMARY_COLOR)),
                  NetworkAvatar(url: history.teacherInfo!.avatar!),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        SizedBox(height: 2),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('No request for lesson'),
              SizedBox(
                height: 10,
              ),
              Container(height: 1, width: double.infinity, color: Colors.grey),
              if (history.reviews!.isEmpty)
                Text('Tutor haven\'t reviewed yet')
              else
                TutorReview()
            ],
          ),
        ),
        Container(height: 1, width: double.infinity, color: Colors.blueAccent),
        SizedBox(height: 20)
      ],
    );
  }

  Widget TutorReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Review from tutor'),
        SizedBox(
          height: 10,
        ),
        Text(
          'Session ${history.lessonDetail?.start?.toString()}-${history.lessonDetail?.end?.toString()}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Lesson status: ${history.lessonDetail?.levelStatus?.toString()}'),
        Text('Lesson progress: ${history.lessonDetail?.progress?.toString()}'),
        Column(
          children: history.reviews?.map((e) => _skillRating(e)).toList() ?? [],
        ),
        Text('Overall comment: ${history.comment?.toString()}'),
        SizedBox(height: 10),
        Container(height: 1, width: double.infinity, color: Colors.grey),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: () {}, child: Text('Add a Rating')),
            TextButton(onPressed: () {}, child: Text('Report')),
          ],
        )
      ],
    );
  }

  Widget _skillRating(Reviews review) {
    return Row(
      children: [
        Text(review.type ?? ''),
        Stars(
          onRatingChanged: (v) {},
          rating: review.star ?? 0,
        ),
      ],
    );
  }
}

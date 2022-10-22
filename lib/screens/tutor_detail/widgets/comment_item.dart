import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/comment.dart';
import 'package:lettutor_app/utils/helper.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/stars.dart';

class CommentItem extends StatelessWidget with Dimension {
  const CommentItem({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NetworkAvatar(
              url: comment.firstInfo?.avatar ?? "",
              width: 50,
              height: 50,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.firstInfo?.name ?? "",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stars(
                        onRatingChanged: (value) {},
                        rating: 5,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(getTimeAgo(
                          comment?.createdAt ?? "2022-09-14T11:26:18.056Z")),
                    ],
                  ),
                ),
                if (hasValue(comment.content))
                  SizedBox(
                    height: comment.content!.length / 30 * 20,
                    width: width(context) * 0.6,
                    child: Text(
                      comment.content!,
                      maxLines: 10,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}

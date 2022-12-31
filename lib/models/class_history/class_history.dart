import 'package:json_annotation/json_annotation.dart';

import 'class_review.dart';
import 'feedback.dart';
import 'schedule_detail_info.dart';
part 'class_history.g.dart';

@JsonSerializable()
class ClassHistory {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  String? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  String? recordUrl;
  String? cancelReasonId;
  String? cancelNote;
  bool? isDeleted;
  ScheduleDetailInfo? scheduleDetailInfo;
  ClassReview? classReview;
  bool? showRecordUrl;
  List<Feedback>? feedbacks;

  ClassHistory(
      {this.createdAtTimeStamp,
        this.updatedAtTimeStamp,
        this.id,
        this.userId,
        this.scheduleDetailId,
        this.tutorMeetingLink,
        this.studentMeetingLink,
        this.studentRequest,
        this.tutorReview,
        this.scoreByTutor,
        this.createdAt,
        this.updatedAt,
        this.recordUrl,
        this.cancelReasonId,
        this.cancelNote,
        this.isDeleted,
        this.scheduleDetailInfo,
        this.classReview,
        this.showRecordUrl,
        this.feedbacks});


  factory ClassHistory.fromJson(Map<String, dynamic> json) => _$ClassHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$ClassHistoryToJson(this);
}
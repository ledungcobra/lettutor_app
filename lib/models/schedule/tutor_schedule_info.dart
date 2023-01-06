import 'package:json_annotation/json_annotation.dart';

import 'schedule_detail.dart';

part 'tutor_schedule_info.g.dart';

@JsonSerializable()
class TutorScheduleInfo {
  String? id;
  String? tutorId;
  String? startTime;
  String? endTime;
  int? startTimestamp;
  int? endTimestamp;
  String? createdAt;
  bool? isBooked;
  List<ScheduleDetail>? scheduleDetails;

  TutorScheduleInfo(
      {this.id,
        this.tutorId,
        this.startTime,
        this.endTime,
        this.startTimestamp,
        this.endTimestamp,
        this.createdAt,
        this.isBooked,
        this.scheduleDetails});

  factory TutorScheduleInfo.fromJson(Map<String, dynamic> json) =>
      _$TutorScheduleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TutorScheduleInfoToJson(this);
}


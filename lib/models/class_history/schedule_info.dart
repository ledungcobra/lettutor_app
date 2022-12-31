import 'package:json_annotation/json_annotation.dart';
import 'tutor_info.dart';
part 'schedule_info.g.dart';

@JsonSerializable()
class ScheduleInfo {
  String? date;
  int? startTimestamp;
  int? endTimestamp;
  String? id;
  String? tutorId;
  String? startTime;
  String? endTime;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  TutorInfo? tutorInfo;

  ScheduleInfo(
      {this.date,
        this.startTimestamp,
        this.endTimestamp,
        this.id,
        this.tutorId,
        this.startTime,
        this.endTime,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.tutorInfo});


  factory ScheduleInfo.fromJson(Map<String, dynamic> json) => _$ScheduleInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleInfoToJson(this);
}
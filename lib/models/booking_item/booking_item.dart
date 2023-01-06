import 'package:json_annotation/json_annotation.dart';
import 'schedule_detail_info.dart';
part 'booking_item.g.dart';

@JsonSerializable()
class BookingItem {

  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  String? createdAt;
  String? updatedAt;
  ScheduleDetailInfo? scheduleDetailInfo;

  BookingItem(
      {this.createdAtTimeStamp,
        this.updatedAtTimeStamp,
        this.id,
        this.userId,
        this.scheduleDetailId,
        this.tutorMeetingLink,
        this.studentMeetingLink,
        this.studentRequest,
        this.tutorReview,
        this.createdAt,
        this.updatedAt,
        this.scheduleDetailInfo});

  factory BookingItem.fromJson(Map<String, dynamic> json) => _$BookingItemFromJson(json);
  Map<String, dynamic> toJson() => _$BookingItemToJson(this);
}


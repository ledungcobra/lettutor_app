// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_schedule_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorScheduleInfo _$TutorScheduleInfoFromJson(Map<String, dynamic> json) =>
    TutorScheduleInfo(
      id: json['id'] as String?,
      tutorId: json['tutorId'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      startTimestamp: json['startTimestamp'] as int?,
      endTimestamp: json['endTimestamp'] as int?,
      createdAt: json['createdAt'] as String?,
      isBooked: json['isBooked'] as bool?,
      scheduleDetails: (json['scheduleDetails'] as List<dynamic>?)
          ?.map((e) => ScheduleDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TutorScheduleInfoToJson(TutorScheduleInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tutorId': instance.tutorId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'startTimestamp': instance.startTimestamp,
      'endTimestamp': instance.endTimestamp,
      'createdAt': instance.createdAt,
      'isBooked': instance.isBooked,
      'scheduleDetails':
          instance.scheduleDetails?.map((e) => e.toJson()).toList(),
    };

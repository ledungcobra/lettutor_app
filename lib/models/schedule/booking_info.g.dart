// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingInfo _$BookingInfoFromJson(Map<String, dynamic> json) => BookingInfo(
      createdAtTimeStamp: json['createdAtTimeStamp'] as int?,
      updatedAtTimeStamp: json['updatedAtTimeStamp'] as int?,
      id: json['id'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      createdAt: json['createdAt'] as String?,
      scheduleDetailId: json['scheduleDetailId'] as String?,
      updatedAt: json['updatedAt'] as String?,
      cancelReasonId: json['cancelReasonId'] as int?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$BookingInfoToJson(BookingInfo instance) =>
    <String, dynamic>{
      'createdAtTimeStamp': instance.createdAtTimeStamp,
      'updatedAtTimeStamp': instance.updatedAtTimeStamp,
      'id': instance.id,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'scheduleDetailId': instance.scheduleDetailId,
      'updatedAt': instance.updatedAt,
      'cancelReasonId': instance.cancelReasonId,
      'userId': instance.userId,
    };

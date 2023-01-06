// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonStatus _$LessonStatusFromJson(Map<String, dynamic> json) => LessonStatus(
      id: json['id'] as num?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$LessonStatusToJson(LessonStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

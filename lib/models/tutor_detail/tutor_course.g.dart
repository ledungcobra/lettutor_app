// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorCourse _$TutorCourseFromJson(Map<String, dynamic> json) => TutorCourse(
      userId: json['userId'] as String?,
      courseId: json['courseId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$TutorCourseToJson(TutorCourse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'courseId': instance.courseId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

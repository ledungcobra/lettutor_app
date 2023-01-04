// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassReview _$ClassReviewFromJson(Map<String, dynamic> json) => ClassReview(
      bookingId: json['bookingId'] as String?,
      lessonStatusId: json['lessonStatusId'] as num?,
      book: json['book'] as String?,
      unit: json['unit'] as String?,
      lesson: json['lesson'] as String?,
      lessonProgress: json['lessonProgress'] as String?,
      behaviorRating: json['behaviorRating'] as num?,
      behaviorComment: json['behaviorComment'] as String?,
      listeningRating: json['listeningRating'] as num?,
      listeningComment: json['listeningComment'] as String?,
      speakingRating: json['speakingRating'] as num?,
      speakingComment: json['speakingComment'] as String?,
      vocabularyRating: json['vocabularyRating'] as num?,
      vocabularyComment: json['vocabularyComment'] as String?,
      homeworkComment: json['homeworkComment'] as String?,
      overallComment: json['overallComment'] as String?,
      lessonStatus: json['lessonStatus'] == null
          ? null
          : LessonStatus.fromJson(json['lessonStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClassReviewToJson(ClassReview instance) =>
    <String, dynamic>{
      'bookingId': instance.bookingId,
      'lessonStatusId': instance.lessonStatusId,
      'book': instance.book,
      'unit': instance.unit,
      'lesson': instance.lesson,
      'lessonProgress': instance.lessonProgress,
      'behaviorRating': instance.behaviorRating,
      'behaviorComment': instance.behaviorComment,
      'listeningRating': instance.listeningRating,
      'listeningComment': instance.listeningComment,
      'speakingRating': instance.speakingRating,
      'speakingComment': instance.speakingComment,
      'vocabularyRating': instance.vocabularyRating,
      'vocabularyComment': instance.vocabularyComment,
      'homeworkComment': instance.homeworkComment,
      'overallComment': instance.overallComment,
      'lessonStatus': instance.lessonStatus?.toJson(),
    };

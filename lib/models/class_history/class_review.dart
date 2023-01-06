import 'package:json_annotation/json_annotation.dart';

import 'lesson_status.dart';
part 'class_review.g.dart';

@JsonSerializable()
class ClassReview {
  String? bookingId;
  num? lessonStatusId;
  String? book;
  String? unit;
  String? lesson;
  String? lessonProgress;
  num? behaviorRating;
  String? behaviorComment;
  num? listeningRating;
  String? listeningComment;
  num? speakingRating;
  String? speakingComment;
  num? vocabularyRating;
  String? vocabularyComment;
  String? homeworkComment;
  String? overallComment;
  LessonStatus? lessonStatus;

  ClassReview(
      {this.bookingId,
        this.lessonStatusId,
        this.book,
        this.unit,
        this.lesson,
        this.lessonProgress,
        this.behaviorRating,
        this.behaviorComment,
        this.listeningRating,
        this.listeningComment,
        this.speakingRating,
        this.speakingComment,
        this.vocabularyRating,
        this.vocabularyComment,
        this.homeworkComment,
        this.overallComment,
        this.lessonStatus});

  factory ClassReview.fromJson(Map<String, dynamic> json) => _$ClassReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ClassReviewToJson(this);
}

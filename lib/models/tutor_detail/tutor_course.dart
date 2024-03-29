import 'package:json_annotation/json_annotation.dart';
part 'tutor_course.g.dart';

@JsonSerializable()
class TutorCourse {
  String? userId;
  String? courseId;
  String? createdAt;
  String? updatedAt;

  TutorCourse({this.userId, this.courseId, this.createdAt, this.updatedAt});

  factory TutorCourse.fromJson(Map<String, dynamic> json) => _$TutorCourseFromJson(json);
  Map<String, dynamic> toJson() => _$TutorCourseToJson(this);
}
import 'package:lettutor_app/models/course.dart';
import 'package:lettutor_app/models/tutor.dart';

class TutorDetail extends Tutor {
  final String video;
  final String education;
  final bool isNative;
  int totalFeedback;
  List<CoursePreview> courses;

  TutorDetail({
    required this.isNative,
    required this.education,
    required this.video,
    required super.id,
    required super.name,
    required super.language,
    required super.specialties,
    required super.avatar,
    required super.rating,
    required super.interests,
    required super.description,
    this.totalFeedback = 0,
    this.courses = const [],
  });
}

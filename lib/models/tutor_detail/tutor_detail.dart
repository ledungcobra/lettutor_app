import 'package:get/get.dart';
import 'package:lettutor_app/models/category_list/category.dart';
import 'package:lettutor_app/services/utils_service.dart';
import 'package:json_annotation/json_annotation.dart';

import 'course.dart';
import 'user.dart';
part 'tutor_detail.g.dart';

@JsonSerializable()
class TutorDetail {
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? accent;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  num? rating;
  bool? isNative;
  User? user;
  bool? isFavorite;
  num? avgRating;
  int? totalFeedback;
  final utilService = Get.find<UtilService>();

  TutorDetail(
      {this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.accent,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.rating,
      this.isNative,
      this.user,
      this.isFavorite,
      this.avgRating,
      this.totalFeedback});

  factory TutorDetail.fromJson(Map<String, dynamic> json) => _$TutorDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TutorDetailToJson(this);

  List<Category> getSpecialties() {
    return  specialties!
        .split(RegExp(","))
        .map((cat) => utilService.specialties[cat])
        .where((element) => element != null)
        .map((x)=> x!)
        .toList();
  }

  List<Category> getLanguages() {
    return specialties!
        .split(RegExp(","))
        .map((cat) => utilService.languages[cat])
        .where((element) => element != null)
        .map((x)=> x!)
        .toList();
  }

  List<Course> getCourses() {
    return user?.courses ?? [];
  }
}

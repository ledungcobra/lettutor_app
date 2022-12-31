import 'package:get/get.dart';
import 'package:lettutor_app/models/category_list/category.dart';
import '../../services/utils_service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'feedback.dart';

part 'tutor.g.dart';

@JsonSerializable()
class Tutor {
  String? email;
  String? google;
  String? avatar;
  String? name;
  String? country;
  String? birthday;
  bool? requestPassword;
  bool? isActivated;
  bool? isPhoneActivated;
  int? timezone;
  bool? isPhoneAuthActivated;
  bool? canSendMessage;
  bool? isPublicRecord;
  String? createdAt;
  String? updatedAt;
  List<Feedback>? feedbacks;
  String? id;
  String? userId;
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  num? rating;
  bool? isNative;
  int? price;
  bool? isOnline;
  String? secondId;

  @JsonKey(ignore: true)
  bool isFavorite = false;
  @JsonKey(ignore: true)
  final utilService = Get.find<UtilService>();

  Tutor(
      {this.email,
      this.google,
      this.avatar,
      this.name,
      this.country,
      this.birthday,
      this.requestPassword,
      this.isActivated,
      this.isPhoneActivated,
      this.timezone,
      this.isPhoneAuthActivated,
      this.canSendMessage,
      this.isPublicRecord,
      this.createdAt,
      this.updatedAt,
      this.feedbacks,
      this.id,
      this.userId,
      this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.rating,
      this.isNative,
      this.price,
      this.isOnline});

  factory Tutor.fromJson(Map<String, dynamic> json) => _$TutorFromJson(json);

  Map<String, dynamic> toJson() => _$TutorToJson(this);

  List<Category> getSpecialties() {
    return (specialties ?? "")
        .split(RegExp(","))
        .map((specialty) =>
            utilService.specialties[specialty] ??
            Category(description: specialty))
        .toList();
  }
}
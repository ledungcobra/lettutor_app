import 'package:json_annotation/json_annotation.dart';
part 'profile_dto.g.dart';

@JsonSerializable()
class ProfileDto {
  String name;
  String country;
  String birthday;
  List<String> learnTopics;
  String level;
  String phone;
  String studySchedule;
  List<String> testPreparations;

  ProfileDto(
      {required this.name,
      required this.country,
      required this.birthday,
      required this.learnTopics,
      required this.level,
      required this.phone,
      required this.studySchedule,
      required this.testPreparations});

  factory ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);
}

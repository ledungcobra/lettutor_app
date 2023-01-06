import 'package:json_annotation/json_annotation.dart';

import 'learn_topic.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  bool? isActivated;
  String? level;
  String? studySchedule;
  List<LearnTopic>? learnTopics;
  List<LearnTopic>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  bool? canSendMessage;

  User(
      {this.id,
        this.email,
        this.name,
        this.avatar,
        this.country,
        this.phone,
        this.roles,
        this.language,
        this.birthday,
        this.isActivated,
        this.level,
        this.learnTopics,
        this.testPreparations,
        this.isPhoneActivated,
        this.timezone,
        this.studySchedule,
        this.canSendMessage});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import 'course.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? level;
  String? avatar;
  String? name;
  String? country;
  String? language;
  bool? isPublicRecord;
  List<Course>? courses;

  User(
      {this.id,
        this.level,
        this.avatar,
        this.name,
        this.country,
        this.language,
        this.isPublicRecord,
        this.courses});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

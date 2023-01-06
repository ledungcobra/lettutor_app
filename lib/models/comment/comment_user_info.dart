import 'package:json_annotation/json_annotation.dart';
part 'comment_user_info.g.dart';


@JsonSerializable()
class CommentUserInfo {
  String? name;
  String? avatar;
  CommentUserInfo({this.name, this.avatar});

  factory CommentUserInfo.fromJson(Map<String, dynamic> json) => _$CommentUserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CommentUserInfoToJson(this);
}
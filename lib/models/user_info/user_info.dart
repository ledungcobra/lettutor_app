import 'package:json_annotation/json_annotation.dart';

import 'token_list.dart';
import 'user.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {

  User? user;
  TokenList? tokens;

  UserInfo({this.user, this.tokens});

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}


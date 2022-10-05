import 'package:lettutor_app/utils/helper.dart';

class UserInfo {
  String? name;
  String? avatar;

  UserInfo({this.name, this.avatar});

  UserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}
import 'package:json_annotation/json_annotation.dart';

part 'access.g.dart';

@JsonSerializable()
class Access {
  String? token;
  String? expires;

  Access({this.token, this.expires});
  factory Access.fromJson(Map<String, dynamic> json) => _$AccessFromJson(json);
  Map<String, dynamic> toJson() => _$AccessToJson(this);
}

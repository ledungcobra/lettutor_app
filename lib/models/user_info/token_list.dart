import 'package:json_annotation/json_annotation.dart';
import 'access.dart';
part 'token_list.g.dart';

@JsonSerializable()
class TokenList {
  Access? access;
  Access? refresh;

  TokenList({this.access, this.refresh});

  factory TokenList.fromJson(Map<String, dynamic> json) => _$TokenListFromJson(json);
  Map<String, dynamic> toJson() => _$TokenListToJson(this);
}
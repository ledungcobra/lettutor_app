import 'package:json_annotation/json_annotation.dart';
part 'error.g.dart';

@JsonSerializable()
class ErrorResponse {
  num? statusCode;
  String? message;

  ErrorResponse({this.statusCode, this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
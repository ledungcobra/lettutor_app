import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor_app/models/comment/comment_user_info.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  String? id;
  String? bookingId;
  String? firstId;
  String? secondId;
  double? rating;
  String? content;
  String? createdAt;
  String? updatedAt;
  CommentUserInfo? firstInfo;

  Comment(
      {this.id,
      this.bookingId,
      this.firstId,
      this.secondId,
      this.rating,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.firstInfo});

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
part 'feedback.g.dart';

@JsonSerializable()
class Feedback {
  String? id;
  String? bookingId;
  String? firstId;
  String? secondId;
  num? rating;
  String? content;
  String? createdAt;
  String? updatedAt;

  Feedback(
      {this.id,
        this.bookingId,
        this.firstId,
        this.secondId,
        this.rating,
        this.content,
        this.createdAt,
        this.updatedAt});


  factory Feedback.fromJson(Map<String, dynamic> json) => _$FeedbackFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
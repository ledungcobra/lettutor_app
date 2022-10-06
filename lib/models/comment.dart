import 'package:lettutor_app/models/user_info.dart';

class Comment {
  String? id;
  String? bookingId;
  String? firstId;
  String? secondId;
  double? rating;
  String? content;
  String? createdAt;
  String? updatedAt;
  UserInfo? firstInfo;

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

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    firstId = json['firstId'];
    secondId = json['secondId'];
    rating = double.parse(json['rating'].toString());
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    firstInfo =
        json['firstInfo'] != null ? UserInfo.fromJson(json['firstInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookingId'] = bookingId;
    data['firstId'] = firstId;
    data['secondId'] = this.secondId;
    data['rating'] = this.rating;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (firstInfo != null) {
      data['firstInfo'] = firstInfo!.toJson();
    }
    return data;
  }
}

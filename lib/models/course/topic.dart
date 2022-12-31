import 'package:json_annotation/json_annotation.dart';
part 'topic.g.dart';

@JsonSerializable()
class Topic {
  String? id;
  String? courseId;
  int? orderCourse;
  String? name;
  String? nameFile;
  num? numberOfPages;
  String? description;
  String? videoUrl;
  String? createdAt;
  String? updatedAt;
  
  Topic(
      {this.id,
        this.courseId,
        this.orderCourse,
        this.name,
        this.nameFile,
        this.numberOfPages,
        this.description,
        this.videoUrl,
        this.createdAt,
        this.updatedAt});

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

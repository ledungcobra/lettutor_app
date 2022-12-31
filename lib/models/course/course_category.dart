import 'package:json_annotation/json_annotation.dart';
part 'course_category.g.dart';

@JsonSerializable()
class Categories {
  String? id;
  String? title;
  String? description;
  String? key;
  String? createdAt;
  String? updatedAt;

  Categories(
      {this.id,
        this.title,
        this.description,
        this.key,
        this.createdAt,
        this.updatedAt});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Categories &&
              runtimeType == other.runtimeType &&
              key == other.key;

  @override
  int get hashCode => key.hashCode;

  factory Categories.fromJson(Map<String, dynamic> json) => _$CategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesToJson(this);

}
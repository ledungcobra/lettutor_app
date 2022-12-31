import 'package:json_annotation/json_annotation.dart';
part 'book_category.g.dart';

@JsonSerializable()
class BookCategory {
  String? id;
  String? title;
  String? description;
  String? key;
  String? createdAt;
  String? updatedAt;

  BookCategory(
      {this.id,
        this.title,
        this.description,
        this.key,
        this.createdAt,
        this.updatedAt});

  factory BookCategory.fromJson(Map<String, dynamic> json) => _$BookCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$BookCategoryToJson(this);
}

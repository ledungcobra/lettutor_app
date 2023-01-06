import 'package:json_annotation/json_annotation.dart';

import 'book_category.dart';
part 'book.g.dart';

@JsonSerializable()
class Book {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  bool? visible;
  String? fileUrl;
  String? createdAt;
  String? updatedAt;
  List<BookCategory>? categories;

  Book(
      {this.id,
        this.name,
        this.description,
        this.imageUrl,
        this.level,
        this.visible,
        this.fileUrl,
        this.createdAt,
        this.updatedAt,
        this.categories});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}

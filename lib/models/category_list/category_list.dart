import 'package:json_annotation/json_annotation.dart';

import 'category.dart';

part 'category_list.g.dart';

@JsonSerializable()
class CategoryList {
  String? id;
  String? title;
  List<Category>? categories;

  CategoryList({this.id, this.title, this.categories});

  factory CategoryList.fromJson(Map<String, dynamic> json) =>
      _$CategoryListFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListToJson(this);

  @override
  String toString() {
    return 'CategoryItems{id: $id, title: $title, categories: ${categories.toString()}}';
  }
}

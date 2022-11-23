class CategoryItems {
  String? id;
  String? title;
  List<Category>? categories;

  CategoryItems({this.id, this.title, this.categories});

  CategoryItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'CategoryItems{id: $id, title: $title, categories: ${categories.toString()}}';
  }
}

class Category {
  String? id;
  String? description;
  String? key;

  Category({this.id, this.description, this.key});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['key'] = this.key;
    return data;
  }
}

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
  Null? isPrivate;
  Null? createdBy;
  List<Categories>? categories;

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
        this.isPrivate,
        this.createdBy,
        this.categories});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    level = json['level'];
    visible = json['visible'];
    fileUrl = json['fileUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isPrivate = json['isPrivate'];
    createdBy = json['createdBy'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['level'] = this.level;
    data['visible'] = this.visible;
    data['fileUrl'] = this.fileUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isPrivate'] = this.isPrivate;
    data['createdBy'] = this.createdBy;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? id;
  String? title;
  Null? description;
  String? key;
  Null? displayOrder;
  String? createdAt;
  String? updatedAt;

  Categories(
      {this.id,
        this.title,
        this.description,
        this.key,
        this.displayOrder,
        this.createdAt,
        this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    key = json['key'];
    displayOrder = json['displayOrder'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['key'] = this.key;
    data['displayOrder'] = this.displayOrder;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Language {
  String? id;
  String? description;
  String? key;

  Language({this.id, this.description, this.key});

  Language.fromJson(Map<String, dynamic> json) {
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
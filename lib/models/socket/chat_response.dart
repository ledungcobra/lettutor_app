class Chat {
  String? id;
  String? content;
  bool? isRead;
  String? createdAt;
  String? updatedAt;
  FromInfo? fromInfo;
  FromInfo? toInfo;
  String? fromId;
  String? toId;

  Chat(
      {this.id,
      this.content,
      this.isRead,
      this.createdAt,
      this.updatedAt,
      this.fromInfo,
      this.toInfo});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isRead = json['isRead'];
    createdAt = json['createdAt'];
    fromId = json['fromId'];
    toId = json['toId'];
    updatedAt = json['updatedAt'];
    fromInfo = json['fromInfo'] != null
        ? new FromInfo.fromJson(json['fromInfo'])
        : null;
    toInfo =
        json['toInfo'] != null ? new FromInfo.fromJson(json['toInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['isRead'] = this.isRead;
    data['createdAt'] = this.createdAt;
    data['fromId'] = this.fromId;
    data['toId'] = this.toId;
    data['updatedAt'] = this.updatedAt;
    if (this.fromInfo != null) {
      data['fromInfo'] = this.fromInfo!.toJson();
    }
    if (this.toInfo != null) {
      data['toInfo'] = this.toInfo!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chat && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  bool isAuthor(String? userId) {
    return fromInfo?.id == userId || fromId == userId;
  }
}

class FromInfo {
  String? id;
  String? name;

  FromInfo({this.id, this.name});

  FromInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

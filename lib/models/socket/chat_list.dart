class ChatList {

  List<RecentList>? recentList;
  int? unreadCount;

  ChatList({this.recentList, this.unreadCount});

  ChatList.fromJson(Map<String, dynamic> json) {
    if (json['recentList'] != null) {
      recentList = <RecentList>[];
      json['recentList'].forEach((v) {
        recentList!.add(new RecentList.fromJson(v));
      });
    }
    unreadCount = json['unreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recentList != null) {
      data['recentList'] = this.recentList!.map((v) => v.toJson()).toList();
    }
    data['unreadCount'] = this.unreadCount;
    return data;
  }
}

class RecentList {
  String? id;
  String? content;
  bool? isRead;
  String? createdAt;
  FromInfo? fromInfo;
  FromInfo? toInfo;
  Partner? partner;

  RecentList(
      {this.id,
      this.content,
      this.isRead,
      this.createdAt,
      this.fromInfo,
      this.toInfo,
      this.partner});

  RecentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isRead = json['isRead'];
    createdAt = json['createdAt'];
    fromInfo = json['fromInfo'] != null
        ? new FromInfo.fromJson(json['fromInfo'])
        : null;
    toInfo =
        json['toInfo'] != null ? new FromInfo.fromJson(json['toInfo']) : null;
    partner =
        json['partner'] != null ? new Partner.fromJson(json['partner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['isRead'] = this.isRead;
    data['createdAt'] = this.createdAt;
    if (this.fromInfo != null) {
      data['fromInfo'] = this.fromInfo!.toJson();
    }
    if (this.toInfo != null) {
      data['toInfo'] = this.toInfo!.toJson();
    }
    if (this.partner != null) {
      data['partner'] = this.partner!.toJson();
    }
    return data;
  }
}

class FromInfo {
  String? id;
  String? name;
  String? avatar;
  bool isOnline = false;

  FromInfo({this.id, this.name, this.avatar, this.isOnline = false});

  FromInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Partner {
  String? id;
  String? name;
  String? avatar;
  bool? isOnline;

  Partner({this.id, this.name, this.avatar, this.isOnline});

  Partner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['isOnline'] = this.isOnline;
    return data;
  }
}

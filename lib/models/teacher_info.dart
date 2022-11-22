class TeacherInfo {
  TeacherInfo({
      this.avatar, 
      this.nationality, 
      this.name,});

  TeacherInfo.fromJson(dynamic json) {
    avatar = json['avatar'];
    nationality = json['nationality'];
    name = json['name'];
  }
  String? avatar;
  String? nationality;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avatar'] = avatar;
    map['nationality'] = nationality;
    map['name'] = name;
    return map;
  }

}
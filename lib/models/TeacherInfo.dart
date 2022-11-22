/// avatar : "https://api.app.lettutor.com/avatar/64cd2606-57f5-439a-a9f3-26d1b5b7d314avatar1648745047315.jpg"
/// nationality : "FR"
/// name : "Keegan"

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
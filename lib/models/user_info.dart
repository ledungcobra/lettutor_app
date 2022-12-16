import 'package:lettutor_app/utils/helper.dart';

class UserInfo {
  User? user;
  Tokens? tokens;

  UserInfo({this.user, this.tokens});

  UserInfo.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tokens =
        json['tokens'] != null ? new Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class User {
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  bool? isActivated;
  String? level;
  String? studySchedule;
  List<LearnTopics>? learnTopics;
  List<LearnTopics>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  bool? canSendMessage;

  User(
      {this.id,
      this.email,
      this.name,
      this.avatar,
      this.country,
      this.phone,
      this.roles,
      this.language,
      this.birthday,
      this.isActivated,
      this.level,
      this.learnTopics,
      this.testPreparations,
      this.isPhoneActivated,
      this.timezone,
      this.studySchedule,
      this.canSendMessage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    country = json['country'];
    phone = json['phone'];
    if (json['roles'] != null) {
      roles = <String>[];
      json['roles'].forEach((v) {
        roles!.add(v);
      });
    }
    language = json['language'];
    birthday = json['birthday'];
    isActivated = json['isActivated'];
    level = json['level'];

    if (json['learnTopics'] != null) {
      learnTopics = <LearnTopics>[];
      json['learnTopics'].forEach((v) {
        learnTopics!.add(new LearnTopics.fromJson(v));
      });
    }
    studySchedule = json['studySchedule'];
    if (json['testPreparations'] != null) {
      testPreparations = <LearnTopics>[];
      json['testPreparations'].forEach((v) {
        testPreparations!.add(new LearnTopics.fromJson(v));
      });
    }
    isPhoneActivated = json['isPhoneActivated'];
    timezone = json['timezone'];
    canSendMessage = json['canSendMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['roles'] = this.roles;
    data['language'] = this.language;
    data['studySchedule'] = this.studySchedule;
    data['birthday'] = this.birthday;
    data['isActivated'] = this.isActivated;
    data['level'] = this.level;
    if (learnTopics != null) {
      data['learnTopics'] = this.learnTopics!.map((v) => v.toJson()).toList();
    }
    if (testPreparations != null) {
      data['testPreparations'] =
          this.testPreparations!.map((v) => v.toJson()).toList();
    }
    data['isPhoneActivated'] = this.isPhoneActivated;
    data['timezone'] = this.timezone;
    data['canSendMessage'] = this.canSendMessage;
    return data;
  }
}

class LearnTopics {
  int? id;
  String? key;
  String? name;

  LearnTopics({this.id, this.key, this.name});

  LearnTopics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }
}

class Tokens {
  Access? access;
  Access? refresh;

  Tokens({this.access, this.refresh});

  Tokens.fromJson(Map<String, dynamic> json) {
    access =
        json['access'] != null ? new Access.fromJson(json['access']) : null;
    refresh =
        json['refresh'] != null ? new Access.fromJson(json['refresh']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.access != null) {
      data['access'] = this.access!.toJson();
    }
    if (this.refresh != null) {
      data['refresh'] = this.refresh!.toJson();
    }
    return data;
  }
}

class Access {
  String? token;
  String? expires;

  Access({this.token, this.expires});

  Access.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expires'] = this.expires;
    return data;
  }
}

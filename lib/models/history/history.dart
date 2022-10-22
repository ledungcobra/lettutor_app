class History {
  String? id;
  LessonDetail? lessonDetail;
  List<Reviews>? reviews;
  String? comment;
  TeacherInfo? teacherInfo;

  History(
      {this.id,
        this.lessonDetail,
        this.reviews,
        this.comment,
        this.teacherInfo});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lessonDetail = json['lessonDetail'] != null
        ? new LessonDetail.fromJson(json['lessonDetail'])
        : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    comment = json['comment'];
    teacherInfo = json['teacherInfo'] != null
        ? new TeacherInfo.fromJson(json['teacherInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.lessonDetail != null) {
      data['lessonDetail'] = this.lessonDetail!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['comment'] = this.comment;
    if (this.teacherInfo != null) {
      data['teacherInfo'] = this.teacherInfo!.toJson();
    }
    return data;
  }
}

class LessonDetail {
  String? start;
  String? end;
  String? levelStatus;
  String? progress;

  LessonDetail({this.start, this.end, this.levelStatus, this.progress});

  LessonDetail.fromJson(Map<String, dynamic> json) {
    start = json['start:'];
    end = json['end'];
    levelStatus = json['levelStatus'];
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start:'] = this.start;
    data['end'] = this.end;
    data['levelStatus'] = this.levelStatus;
    data['progress'] = this.progress;
    return data;
  }
}

class Reviews {
  String? type;
  double? star;

  Reviews({this.type, this.star});

  Reviews.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    star = double.parse(json['star'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['star'] = this.star;
    return data;
  }
}

class TeacherInfo {
  String? avatar;
  String? nationality;
  String? name;

  TeacherInfo({this.avatar, this.nationality, this.name});

  TeacherInfo.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    nationality = json['nationality'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['nationality'] = this.nationality;
    data['name'] = this.name;
    return data;
  }
}
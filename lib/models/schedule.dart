import 'teacher_info.dart';

class Schedule {
  Schedule({
    this.date,
    this.lessonCount,
    this.teacherInfo,
    this.startTime,
    this.endTime,
    this.status,
    this.note,
  });

  Schedule.fromJson(dynamic json) {
    date = json['date'];
    lessonCount = json['lessonCount'];
    teacherInfo = json['teacherInfo'] != null
        ? TeacherInfo.fromJson(json['teacherInfo'])
        : null;
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    note = json['note'];
  }

  String? date;
  int? lessonCount;
  TeacherInfo? teacherInfo;
  String? startTime;
  String? endTime;
  String? status;
  String? note;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['lessonCount'] = lessonCount;
    if (teacherInfo != null) {
      map['teacherInfo'] = teacherInfo?.toJson();
    }
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['status'] = status;
    map['note'] = note;
    return map;
  }
}

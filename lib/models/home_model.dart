import 'package:lettutor_app/models/tutor.dart';

class HomeModel {
  Header? header;
  List<Tutor>? recommendTutors;

  HomeModel({this.header, this.recommendTutors});

  HomeModel.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? Header.fromJson(json['header']) : null;
    if (json['recommend_tutors'] != null) {
      recommendTutors = <Tutor>[];
      json['recommend_tutors'].forEach((v) {
        recommendTutors!.add(Tutor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header!.toJson();
    }
    if (this.recommendTutors != null) {
      data['recommend_tutors'] =
          this.recommendTutors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Header {
  String? totalLessonTime;
  UpcomingLesson? upcomingLesson;

  Header({this.totalLessonTime, this.upcomingLesson});

  Header.fromJson(Map<String, dynamic> json) {
    totalLessonTime = json['total_lesson_time'];
    upcomingLesson = json['upcoming_lesson'] != null
        ? new UpcomingLesson.fromJson(json['upcoming_lesson'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_lesson_time'] = this.totalLessonTime;
    if (this.upcomingLesson != null) {
      data['upcoming_lesson'] = this.upcomingLesson!.toJson();
    }
    return data;
  }
}

class UpcomingLesson {
  String? lessonId;
  String? timeStart;

  UpcomingLesson({this.lessonId, this.timeStart});

  UpcomingLesson.fromJson(Map<String, dynamic> json) {
    lessonId = json['lesson_id'];
    timeStart = json['time_start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lesson_id'] = this.lessonId;
    data['time_start'] = this.timeStart;
    return data;
  }
}

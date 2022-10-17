import 'package:lettutor_app/models/tutor.dart';

class HomeModel {
  Header? header;
  List<RecommendTutors>? recommendTutors;

  HomeModel({this.header, this.recommendTutors});

  HomeModel.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    if (json['recommend_tutors'] != null) {
      recommendTutors = <RecommendTutors>[];
      json['recommend_tutors'].forEach((v) {
        recommendTutors!.add(new RecommendTutors.fromJson(v));
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

class RecommendTutors {
  String? email;
  String? avatar;
  String? name;
  String? country;
  String? phone;
  String? language;
  String? birthday;
  bool? isPhoneAuthActivated;
  bool? canSendMessage;
  bool? isPublicRecord;
  String? createdAt;
  String? updatedAt;
  List<Null>? feedbacks;
  String? id;
  String? userId;
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? accent;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  String? resume;
  int? price;
  bool? isOnline;

  RecommendTutors(
      {this.email,
      this.avatar,
      this.name,
      this.country,
      this.phone,
      this.language,
      this.birthday,
      this.isPhoneAuthActivated,
      this.canSendMessage,
      this.isPublicRecord,
      this.createdAt,
      this.updatedAt,
      this.feedbacks,
      this.id,
      this.userId,
      this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.accent,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.resume,
      this.price,
      this.isOnline});

  RecommendTutors.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday = json['birthday'];
    isPhoneAuthActivated = json['isPhoneAuthActivated'];
    canSendMessage = json['canSendMessage'];
    isPublicRecord = json['isPublicRecord'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    userId = json['userId'];
    video = json['video'];
    bio = json['bio'];
    education = json['education'];
    experience = json['experience'];
    profession = json['profession'];
    accent = json['accent'];
    targetStudent = json['targetStudent'];
    interests = json['interests'];
    languages = json['languages'];
    specialties = json['specialties'];
    resume = json['resume'];
    price = json['price'];
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['language'] = this.language;
    data['birthday'] = this.birthday;
    data['isPhoneAuthActivated'] = this.isPhoneAuthActivated;
    data['canSendMessage'] = this.canSendMessage;
    data['isPublicRecord'] = this.isPublicRecord;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['video'] = this.video;
    data['bio'] = this.bio;
    data['education'] = this.education;
    data['experience'] = this.experience;
    data['profession'] = this.profession;
    data['accent'] = this.accent;
    data['targetStudent'] = this.targetStudent;
    data['interests'] = this.interests;
    data['languages'] = this.languages;
    data['specialties'] = this.specialties;
    data['resume'] = this.resume;
    data['price'] = this.price;
    data['isOnline'] = this.isOnline;
    return data;
  }

  Tutor toTutor() {
    return Tutor(
        name: this.name ?? "",
        id: id ?? "",
        avatar: this.avatar ?? "",
        description: this.bio ?? "",
        specialties: this.specialties?.split(RegExp(",")).toList() ?? [],
        interests: this.interests ?? "Not available",
        language: this.language?.split(RegExp(",")) ?? [],
        rating: 5,
        teachingExperience: this.experience ?? "Not available");
  }
}

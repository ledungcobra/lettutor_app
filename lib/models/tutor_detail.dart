import 'package:get/get.dart';
import 'package:lettutor_app/models/category_items.dart';
import 'package:lettutor_app/services/utils_service.dart';

class TutorDetail {
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
  num? rating;
  bool? isNative;
  User? user;
  bool? isFavorite;
  num? avgRating;
  int? totalFeedback;
  final utilService = Get.find<UtilService>();

  TutorDetail(
      {this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.accent,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.rating,
      this.isNative,
      this.user,
      this.isFavorite,
      this.avgRating,
      this.totalFeedback});

  TutorDetail.fromJson(Map<String, dynamic> json) {
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
    rating = json['rating'];
    isNative = json['isNative'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
    isFavorite = json['isFavorite'];
    avgRating = json['avgRating'];
    totalFeedback = json['totalFeedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['rating'] = this.rating;
    data['isNative'] = this.isNative;
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    data['isFavorite'] = this.isFavorite;
    data['avgRating'] = this.avgRating;
    data['totalFeedback'] = this.totalFeedback;
    return data;
  }

  List<Category> getSpecialties() {
    return  specialties!
        .split(RegExp(","))
        .map((cat) => utilService.specialties[cat])
        .where((element) => element != null)
        .map((x)=> x!)
        .toList();
  }

  List<Category> getLanguages() {
    return specialties!
        .split(RegExp(","))
        .map((cat) => utilService.languages[cat])
        .where((element) => element != null)
        .map((x)=> x!)
        .toList();
  }

  List<Courses> getCourses() {
    return user!.courses!;
  }
}

class User {
  String? id;
  String? level;
  String? avatar;
  String? name;
  String? country;
  String? language;
  bool? isPublicRecord;
  List<Courses>? courses;

  User(
      {this.id,
      this.level,
      this.avatar,
      this.name,
      this.country,
      this.language,
      this.isPublicRecord,
      this.courses});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    language = json['language'];
    isPublicRecord = json['isPublicRecord'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level'] = this.level;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['country'] = this.country;
    data['language'] = this.language;
    data['isPublicRecord'] = this.isPublicRecord;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  String? id;
  String? name;
  TutorCourse? tutorCourse;

  Courses({this.id, this.name, this.tutorCourse});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tutorCourse = json['TutorCourse'] != null
        ? new TutorCourse.fromJson(json['TutorCourse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.tutorCourse != null) {
      data['TutorCourse'] = this.tutorCourse!.toJson();
    }
    return data;
  }
}

class TutorCourse {
  String? userId;
  String? courseId;
  String? createdAt;
  String? updatedAt;

  TutorCourse({this.userId, this.courseId, this.createdAt, this.updatedAt});

  TutorCourse.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    courseId = json['CourseId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['CourseId'] = this.courseId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

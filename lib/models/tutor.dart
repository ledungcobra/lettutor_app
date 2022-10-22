class Tutor {
   String? email;
  String? google;
  String? avatar;
  String? name;
  String? country;
  String? birthday;
  bool? requestPassword;
  bool? isActivated;
  bool? isPhoneActivated;
   int? timezone;
   bool? isPhoneAuthActivated;
  bool? canSendMessage;
  bool? isPublicRecord;
   String? createdAt;
  String? updatedAt;
  List<Feedbacks>? feedbacks;
  String? id;
  String? userId;
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  num? rating;
  bool? isNative;
  int? price;
  bool? isOnline;

  Tutor(
      {
        this.email,
        this.google,
        this.avatar,
        this.name,
        this.country,
        this.birthday,
        this.requestPassword,
        this.isActivated,
        this.isPhoneActivated,
        this.timezone,
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
        this.targetStudent,
        this.interests,
        this.languages,
        this.specialties,
        this.rating,
        this.isNative,
        this.price,
        this.isOnline});

  Tutor.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    google = json['google'];
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    birthday = json['birthday'];
    requestPassword = json['requestPassword'];
    isActivated = json['isActivated'];
    isPhoneActivated = json['isPhoneActivated'];
    timezone = json['timezone'];
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
    targetStudent = json['targetStudent'];
    interests = json['interests'];
    languages = json['languages'];
    specialties = json['specialties'];
    rating = json['rating'];
    isNative = json['isNative'];
    price = json['price'];
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['google'] = this.google;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['country'] = this.country;
    data['birthday'] = this.birthday;
    data['requestPassword'] = this.requestPassword;
    data['isActivated'] = this.isActivated;
    data['isPhoneActivated'] = this.isPhoneActivated;
    data['timezone'] = this.timezone;
    data['isPhoneAuthActivated'] = this.isPhoneAuthActivated;
    data['canSendMessage'] = this.canSendMessage;
    data['isPublicRecord'] = this.isPublicRecord;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['video'] = this.video;
    data['bio'] = this.bio;
    data['education'] = this.education;
    data['experience'] = this.experience;
    data['profession'] = this.profession;
    data['targetStudent'] = this.targetStudent;
    data['interests'] = this.interests;
    data['languages'] = this.languages;
    data['specialties'] = this.specialties;
    data['rating'] = this.rating;
    data['isNative'] = this.isNative;
    data['price'] = this.price;
    data['isOnline'] = this.isOnline;
    return data;
  }

   List<String> getSpecialties() {
     return specialties!.split(RegExp(",")).toList();
   }
}

class Feedbacks {
  String? id;
  String? bookingId;
  String? firstId;
  String? secondId;
  int? rating;
  String? content;
  String? createdAt;
  String? updatedAt;
  FirstInfo? firstInfo;

  Feedbacks(
      {this.id,
        this.bookingId,
        this.firstId,
        this.secondId,
        this.rating,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.firstInfo});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    firstId = json['firstId'];
    secondId = json['secondId'];
    rating = json['rating'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    firstInfo = json['firstInfo'] != null
        ? new FirstInfo.fromJson(json['firstInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookingId'] = this.bookingId;
    data['firstId'] = this.firstId;
    data['secondId'] = this.secondId;
    data['rating'] = this.rating;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.firstInfo != null) {
      data['firstInfo'] = this.firstInfo!.toJson();
    }
    return data;
  }
}

class FirstInfo {
  String? level;
  String? email;
  String? google;
  Null? facebook;
  Null? apple;
  String? avatar;
  String? name;
  String? country;
  String? phone;
  String? language;
  String? birthday;
  bool? requestPassword;
  bool? isActivated;
  bool? isPhoneActivated;
  String? requireNote;
  int? timezone;
  String? phoneAuth;
  bool? isPhoneAuthActivated;
  String? studySchedule;
  bool? canSendMessage;
  bool? isPublicRecord;
  int? caredByStaffId;
  String? zaloUserId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Null? studentGroupId;

  FirstInfo(
      {this.level,
        this.email,
        this.google,
        this.facebook,
        this.apple,
        this.avatar,
        this.name,
        this.country,
        this.phone,
        this.language,
        this.birthday,
        this.requestPassword,
        this.isActivated,
        this.isPhoneActivated,
        this.requireNote,
        this.timezone,
        this.phoneAuth,
        this.isPhoneAuthActivated,
        this.studySchedule,
        this.canSendMessage,
        this.isPublicRecord,
        this.caredByStaffId,
        this.zaloUserId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.studentGroupId});

  FirstInfo.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    email = json['email'];
    google = json['google'];
    facebook = json['facebook'];
    apple = json['apple'];
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday = json['birthday'];
    requestPassword = json['requestPassword'];
    isActivated = json['isActivated'];
    isPhoneActivated = json['isPhoneActivated'];
    requireNote = json['requireNote'];
    timezone = json['timezone'];
    phoneAuth = json['phoneAuth'];
    isPhoneAuthActivated = json['isPhoneAuthActivated'];
    studySchedule = json['studySchedule'];
    canSendMessage = json['canSendMessage'];
    isPublicRecord = json['isPublicRecord'];
    caredByStaffId = json['caredByStaffId'];
    zaloUserId = json['zaloUserId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    studentGroupId = json['studentGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['email'] = this.email;
    data['google'] = this.google;
    data['facebook'] = this.facebook;
    data['apple'] = this.apple;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['language'] = this.language;
    data['birthday'] = this.birthday;
    data['requestPassword'] = this.requestPassword;
    data['isActivated'] = this.isActivated;
    data['isPhoneActivated'] = this.isPhoneActivated;
    data['requireNote'] = this.requireNote;
    data['timezone'] = this.timezone;
    data['phoneAuth'] = this.phoneAuth;
    data['isPhoneAuthActivated'] = this.isPhoneAuthActivated;
    data['studySchedule'] = this.studySchedule;
    data['canSendMessage'] = this.canSendMessage;
    data['isPublicRecord'] = this.isPublicRecord;
    data['caredByStaffId'] = this.caredByStaffId;
    data['zaloUserId'] = this.zaloUserId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['studentGroupId'] = this.studentGroupId;
    return data;
  }


}
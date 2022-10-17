class Meeting {
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  String? createdAt;
  String? updatedAt;
  ScheduleInfo? scheduleInfo;

  Meeting(
      {this.startPeriodTimestamp,
        this.endPeriodTimestamp,
        this.id,
        this.scheduleId,
        this.startPeriod,
        this.endPeriod,
        this.createdAt,
        this.updatedAt,
        this.scheduleInfo});

  Meeting.fromJson(Map<String, dynamic> json) {
    startPeriodTimestamp = json['startPeriodTimestamp'];
    endPeriodTimestamp = json['endPeriodTimestamp'];
    id = json['id'];
    scheduleId = json['scheduleId'];
    startPeriod = json['startPeriod'];
    endPeriod = json['endPeriod'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    scheduleInfo = json['scheduleInfo'] != null
        ? new ScheduleInfo.fromJson(json['scheduleInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startPeriodTimestamp'] = this.startPeriodTimestamp;
    data['endPeriodTimestamp'] = this.endPeriodTimestamp;
    data['id'] = this.id;
    data['scheduleId'] = this.scheduleId;
    data['startPeriod'] = this.startPeriod;
    data['endPeriod'] = this.endPeriod;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.scheduleInfo != null) {
      data['scheduleInfo'] = this.scheduleInfo!.toJson();
    }
    return data;
  }
}

class ScheduleInfo {
  String? date;
  int? startTimestamp;
  int? endTimestamp;
  String? id;
  String? tutorId;
  String? startTime;
  String? endTime;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  TutorInfo? tutorInfo;

  ScheduleInfo(
      {this.date,
        this.startTimestamp,
        this.endTimestamp,
        this.id,
        this.tutorId,
        this.startTime,
        this.endTime,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.tutorInfo});

  ScheduleInfo.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    startTimestamp = json['startTimestamp'];
    endTimestamp = json['endTimestamp'];
    id = json['id'];
    tutorId = json['tutorId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    tutorInfo = json['tutorInfo'] != null
        ? new TutorInfo.fromJson(json['tutorInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['startTimestamp'] = this.startTimestamp;
    data['endTimestamp'] = this.endTimestamp;
    data['id'] = this.id;
    data['tutorId'] = this.tutorId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.tutorInfo != null) {
      data['tutorInfo'] = this.tutorInfo!.toJson();
    }
    return data;
  }
}

class TutorInfo {
  String? id;
  String? level;
  String? email;
  Null? google;
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
  Null? isPhoneActivated;
  Null? requireNote;
  int? timezone;
  Null? phoneAuth;
  bool? isPhoneAuthActivated;
  Null? studySchedule;
  bool? canSendMessage;
  bool? isPublicRecord;
  Null? caredByStaffId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Null? studentGroupId;

  TutorInfo(
      {this.id,
        this.level,
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
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.studentGroupId});

  TutorInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    studentGroupId = json['studentGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['studentGroupId'] = this.studentGroupId;
    return data;
  }
}

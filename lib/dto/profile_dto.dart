import '../models/category_items.dart';
import '../models/user_info.dart';

class ProfileDto {
  String name;
  String country;
  String birthday;
  List<String> learnTopics;
  String level;
  String phone;
  String studySchedule;
  List<String> testPreparations;

  ProfileDto(
      {required this.name,
      required this.country,
      required this.birthday,
      required this.learnTopics,
      required this.level,
      required this.phone,
      required this.studySchedule,
      required this.testPreparations});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {};
    result['name'] = name;
    result['country'] = country;
    result['birthday'] = birthday;
    if(learnTopics != null){
      result['learnTopics'] = learnTopics;
    }
    result['level'] = level;
    result['phone'] = phone;
    result['studySchedule'] = studySchedule;
    result['testPreparations'] = testPreparations;
    return result;
  }
}

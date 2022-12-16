import 'package:get/get.dart';
import 'package:lettutor_app/dto/profile_dto.dart';

class ProfileController {

  final name = ''.obs;
  final country = ''.obs;
  final phone = ''.obs;
  final birthday = ''.obs;
  final level = ''.obs;
  final studySchedule = ''.obs;
  final learnTopicsId = <String>[].obs;
  final testPreparationsId = <String>[].obs;

  ProfileDto getProfileDto(){
    return ProfileDto(
      name: name.value,
      country: country.value,
      phone: phone.value,
      birthday: birthday.value,
      level: level.value,
      studySchedule: studySchedule.value,
      learnTopics: learnTopicsId.value,
      testPreparations: testPreparationsId.value
    );
  }
}
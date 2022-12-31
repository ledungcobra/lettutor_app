import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../models/profile_dto.dart';
import '../../services/user_service.dart';

class ProfileController with HandleUIError {
  final name = ''.obs;
  final country = ''.obs;
  final phone = ''.obs;
  final birthday = ''.obs;
  final level = ''.obs;
  final studySchedule = ''.obs;
  final learnTopicsId = <String>[].obs;
  final testPreparationsId = <String>[].obs;
  final userService = Get.find<UserService>();

  ProfileDto getProfileDto() {
    return ProfileDto(
        name: name.value,
        country: country.value,
        phone: phone.value,
        birthday: birthday.value,
        level: level.value,
        studySchedule: studySchedule.value,
        learnTopics: learnTopicsId.value,
        testPreparations: testPreparationsId.value);
  }

  Future<String> uploadAvatar(XFile file) async {
    return await userService.uploadAvatar(file);;
  }
}

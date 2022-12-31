import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/models/request/become_teacher_dto.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../services/user_service.dart';

class BecomeTutorController with HandleUIError {

  final name = ''.obs;
  final country = ''.obs;
  final phone = ''.obs;
  final birthday = ''.obs;
  final level = ''.obs;
  final studySchedule = ''.obs;
  final learnTopicsId = <String>[].obs;
  final testPreparationsId = <String>[].obs;
  final userService = Get.find<UserService>();

  BecomeTeacherRequest getProfileDto() {
    return BecomeTeacherRequest();
  }

  Future<String> uploadAvatar(XFile file) async {
    return await userService.uploadAvatar(file);;
  }
}

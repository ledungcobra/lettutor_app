import 'package:get/get.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/services/user_service.dart';

import '../../models/home_model.dart';
import '../../models/tutor_detail.dart';

class HomeController extends GetxController {
  final TutorService _tutorService = Get.find();
  final UserService _userService = Get.find();

  var listTutors = <Tutor>[].obs;
  var isLoading = false.obs;
  Rx<Header?> header = Rx(null);
  Rx<TutorDetail?> tutorDetail = Rx(null);
  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    loadingData();
    isLoading.value = false;
  }

  void loadingData() async {
    try{
      var homeModel = await _tutorService.getHomeModel();
      listTutors.value = homeModel.recommendTutors ?? [];
      header.value = homeModel.header;
    }catch(e){
      print(e.toString());
    }

  }

  void findTutorById(String tutorId){

  }
}

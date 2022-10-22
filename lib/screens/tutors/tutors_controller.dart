import 'package:get/get.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/services/tutor_service.dart';

class TutorsController extends GetxController with StateMixin<List<Tutor>>{
  final TutorService _tutorService = Get.find();

  var tutors = <Tutor>[].obs;

  @override
  void onInit(){
    super.onInit();
     initData();
     print('On init');
  }

  void initData() async {
    change([],status: RxStatus.loading());
    RxStatus.loading();
    var tutors= await _tutorService.getTutors();
    change(tutors, status: RxStatus.success());
  }
}

import 'package:get/get.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/types.dart';

class TutorsController extends GetxController with StateMixin<List<Tutor>> {
  final TutorService _tutorService = Get.find();
  final isInit = true.obs;
  var tutors = <Tutor>[];

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    change([], status: RxStatus.loading());
    tutors = await _tutorService.getTutors();
    change(tutors, status: RxStatus.success());
    isInit.value = false;
  }

  void filter(FilterCriteria filterCriteria) {
    change(tutors.where((tutor) => filterCriteria.isOk(tutor)).toList(),
        status: RxStatus.success());
  }

  void like(String userId) {
    var filterTutors = value?.map((t) {
          if (t.userId == userId) {
            t.isFavorite = !t.isFavorite;
          }
          return t;
        }).toList() ??
        [];
    change(filterTutors, status: RxStatus.success());
  }
}

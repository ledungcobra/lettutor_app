import 'package:get/get.dart';
import 'package:lettutor_app/models/category_items.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/utils/types.dart';

import '../../services/utils_service.dart';

class TutorsController extends GetxController with HandleUIError {
  final TutorService _tutorService = Get.find();
  final _tutors = <Tutor>[].obs;
  var page = 1;
  var perPage = 3;
  final selectedNationalities = <Nationality>[].obs;
  final RxInt selectedFilterIndex = 0.obs;
  var tutorName = "";
  final _utilService = Get.find<UtilService>();

  FilterCriteria get filterCriteria => FilterCriteria(
        nationality: selectedNationalities,
        specialty: selectedSkillFilter,
        name: tutorName,
      );

  Category get selectedSkillFilter => _utilService.specialties.entries
      .toList()[selectedFilterIndex.value]
      .value;

  List<Tutor> get tutors => _tutors;

  Map<String?, Category> get skills => _utilService.specialties;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() {
    loadTutors();
  }

  loadTutors() async {
    print('Get tutor page=$page perPage=$perPage');
    var response = await _tutorService.searchTutor(tutorName, filterCriteria,page, perPage);
    if (response.hasError) {
      handleError(response.error!);
      return;
    }
    print('Size ${response.data!.length}');
    _tutors.addAll(response.data!);
    page++;
  }

  void filter() {
    page = 1;
    _tutors.clear();
    loadTutors();
  }

  void like(String userId) {
    print("Like $userId");
    print(_tutors.map((t) => t.userId));
    _tutors.value = _tutors.map((t) {
      if (t.userId == userId) {
        t.isFavorite = !t.isFavorite;
      }
      return t;
    }).toList();
  }
}

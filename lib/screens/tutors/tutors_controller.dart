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

  void initData() async  {
    await loadTutors();
  }

  refreshTutors() async {
    page--;
    if(page<0){
      page = 1;
    }
    _tutors.clear();
    await _load();
  }

  loadTutors() async {
    await _load();
    page++;
  }

  _load() async {
    var response = await _tutorService.searchTutor(tutorName, filterCriteria,page, perPage);
    if (response.hasError) {
      handleError(response.error!);
      return;
    }
    _tutors.addAll(response.data!);
  }

  void filter() {
    page = 1;
    _tutors.clear();
    loadTutors();
  }

  like(String userId) async {
    var index = _tutors.indexWhere((element) => element.userId == userId);
    if(index != -1){
      tutors[index].isFavorite = !tutors[index].isFavorite;
    }
    var response = await _tutorService.performLike(userId);
    if(response.hasError){
      return handleError(response.error!);
    }
  }
}

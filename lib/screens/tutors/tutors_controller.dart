import 'package:get/get.dart';
import 'package:lettutor_app/models/category_list/category.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/utils/types.dart';

import '../../services/utils_service.dart';

class TutorsController extends GetxController
    with HandleUIError
    implements Likable {
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

  void init() async {
    _tutors.clear();
    await loadTutors();
  }

  void initData() async {}

  refreshTutors() async {
    page = 1;
    _tutors.clear();
    await _load();
  }

  loadTutors() async {
    await _load();
    page++;
  }

  _load() async {
    var response = await _tutorService.searchTutor(
        tutorName, filterCriteria, page, perPage);
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

  @override
  Future like(Tutor tutor) async {
    tutor.isFavorite = !tutor.isFavorite;
    var response = await _tutorService.performLike(tutor.userId!);
    if (response.hasError) {
      return handleError(response.error!);
    }
  }
}

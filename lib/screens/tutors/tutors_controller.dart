import 'package:get/get.dart';
import 'package:lettutor_app/models/category_items.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/utils/types.dart';
import '../../services/utils_service.dart';
import '../../utils/constants.dart';

class TutorsController extends GetxController with HandleUIError {
  final TutorService _tutorService = Get.find();
  final _tutors = <Tutor>[].obs;
  var page = 1;
  var perPage = 3;
  final Rx<Nationality> selectedNationality = nationalities.first.obs;
  final RxInt selectedFilterIndex = 0.obs;
  var tutorName = "";
  final _utilService = Get.find<UtilService>();

  FilterCriteria get filterCriteria => FilterCriteria(
        nationality: selectedNationality.value,
        skillFilter: selectedSkillFilter,
        name: tutorName,
      );

  Category get selectedSkillFilter =>
      _utilService.specialties.entries.toList()[selectedFilterIndex.value].value;

  List<Tutor> get tutors =>
      _tutors.where((tutor) => filterCriteria.isOk(tutor)).toList();

  Map<String?, Category> get skills => _utilService.specialties;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    await loadTutors();
  }

  loadTutors() async {
    var response = await _tutorService.getTutorsPaging(page, perPage);
    if (response.hasError) {
      handleError(response.error!);
      return;
    }
    _tutors.addAll(response.data!);
    page++;
  }

  void filter() {}

  void like(String userId) {
    print("Like $userId");
    print(_tutors.map((t)=>t.userId));
    _tutors.value = _tutors.map((t) {
      if (t.userId == userId) {
        t.isFavorite = !t.isFavorite;
      }
      return t;
    }).toList();
  }
}

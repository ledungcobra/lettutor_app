import 'package:get/get.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/home_model.dart';
import '../../models/tutor_detail.dart';

class HomeController extends GetxController with HandleUIError {
  final TutorService _tutorService = Get.find();
  var listTutors = <Tutor>[].obs;
  var loadMore = false.obs;
  var isLoading = false.obs;
  Rx<Header?> header = Rx(null);
  Rx<TutorDetail?> tutorDetail = Rx(null);
  var page = 1;
  var perPage = 2;
  final RefreshController refreshController =
  RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await loadingData();
    isLoading.value = false;
  }

  loadingData() async {
    try {
      var homeModel = await _tutorService.getHomeModel();
      header.value = homeModel.header;
     loadTutors();
    } catch (e) {
      print(e.toString());
    }
  }

  loadTutors() {
    _tutorService.getTutorsPaging(perPage, page).then((tutorResponse){
      if (tutorResponse.hasError) {
        handleError(tutorResponse.error!);
        listTutors.value = [];
        return;
      }
      listTutors.value = tutorResponse.data!;
      loadMore.value = true;
      perPage+=2;
      refreshController.loadComplete();
    });
  }

  void findTutorById(String tutorId) {}

  like(Tutor tutor) {
    listTutors.value = listTutors.map((t) {
      if (t == tutor) {
        t.isFavorite = !t.isFavorite;
      }
      return t;
    }).toList();
  }
  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }
}

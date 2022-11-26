import 'package:get/get.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../models/booking_item.dart';
import '../../models/home_model.dart';
import '../../models/tutor.dart';
import '../../models/tutor_detail.dart';
import '../../services/tutor_service.dart';
import '../../services/user_service.dart';

class HomeController extends GetxController with HandleUIError {
  final TutorService _tutorService = Get.find();
  final userService = Get.find<UserService>();
  var listTutors = <Tutor>[].obs;
  Rx<BookingItem?> header = Rx(null);
  Rx<TutorDetail?> tutorDetail = Rx(null);
  final totalTime = 0.obs;

  var page = 1;
  var perPage = 2;

  @override
  void onInit() {
    super.onInit();
    loadingData();
  }

  loadingData() async {
    try {
      totalTime.value = await userService.getTotalTime();
      await loadNextTutors();
      await getUpcomingLesson();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getUpcomingLesson() async {
      var upComingResponse = await _tutorService.getUpcomingCourse();
    if (upComingResponse.hasData && upComingResponse!.data!.isNotEmpty) {
      var data = upComingResponse.data!;
      var min = data[0];
      for (var i = 1; i < data.length; i++) {
        var startTimeOfCurrent =
            data[i].scheduleDetailInfo?.scheduleInfo?.startTimestamp ?? 0;
        var startTimeOfMin =
            min.scheduleDetailInfo?.scheduleInfo?.startTimestamp ?? 0;
        if (startTimeOfMin > startTimeOfCurrent &&
            startTimeOfCurrent > DateTime.now().millisecondsSinceEpoch) {
          min = data[i];
        }
        header.value = min;
      }
    }
  }

  loadNextTutors() async {
   await _load();
    page++;
  }

  _load() async {
    var tutorResponse = await _tutorService.getTutorsPaging(page, perPage);
    if (tutorResponse.hasError) {
      handleError(tutorResponse.error!);
      listTutors.value = [];
      return;
    }
    listTutors.addAll(tutorResponse.data!);
  }

  refreshTutors () async  {
    page = 1;
    listTutors.clear();
    await _load();
    await getUpcomingLesson();
  }

  like(String? tutorId) async  {
    var index = listTutors.indexWhere((element) => element.userId == tutorId);
    if(index != -1){
      listTutors[index].isFavorite = !listTutors[index].isFavorite;
    }
    var response = await _tutorService.performLike(tutorId!);
    if(response.hasError){
      return handleError(response.error!);
    }
  }
}

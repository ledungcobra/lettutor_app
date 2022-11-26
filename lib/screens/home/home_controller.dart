import 'package:get/get.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../models/booking_item.dart';
import '../../models/home_model.dart';
import '../../models/tutor.dart';
import '../../models/tutor_detail.dart';
import '../../services/tutor_service.dart';

class HomeController extends GetxController with HandleUIError {
  final TutorService _tutorService = Get.find();

  var listTutors = <Tutor>[].obs;
  Rx<BookingItem?> header = Rx(null);
  Rx<TutorDetail?> tutorDetail = Rx(null);

  var page = 1;
  var perPage = 2;

  @override
  void onInit() {
    super.onInit();
    loadingData();
  }

  loadingData() async {
    try {
      await loadTutors();
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
    } catch (e) {
      print(e.toString());
    }
  }

  loadTutors() async {
    var tutorResponse = await _tutorService.getTutorsPaging(page, perPage);
    if (tutorResponse.hasError) {
      handleError(tutorResponse.error!);
      listTutors.value = [];
      // setState(() {});
      return;
    }
    listTutors.addAll(tutorResponse.data!);
    page++;
  }

  like(Tutor tutor) {
    listTutors.value = listTutors.map((t) {
      if (t == tutor) {
        t.isFavorite = !t.isFavorite;
      }
      return t;
    }).toList();
  }
}

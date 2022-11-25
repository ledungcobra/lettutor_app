import 'package:get/get.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../models/booking_item.dart';
import '../../models/home_model.dart';
import '../../models/tutor.dart';
import '../../models/tutor_detail.dart';
import '../../services/tutor_service.dart';

class HomeController extends GetxController  with HandleUIError{

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
      var upComingResponse = await _tutorService.getBookingItems();
      print(upComingResponse.toString());
      if(upComingResponse.hasData && upComingResponse!.data!.isNotEmpty){
        header.value = upComingResponse!.data!.first!;
      }
      loadTutors();
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
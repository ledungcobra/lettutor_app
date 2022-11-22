import 'package:get/get.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../models/home_model.dart';
import '../../models/tutor.dart';
import '../../models/tutor_detail.dart';
import '../../services/tutor_service.dart';

class HomeController extends GetxController  with HandleUIError{

  final TutorService _tutorService = Get.find();

  var listTutors = <Tutor>[].obs;
  Rx<Header?> header = Rx(null);
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
      var homeModel = await _tutorService.getHomeModel();
      header.value = homeModel.header;
      loadTutors();
    } catch (e) {
      print(e.toString());
    }
  }


  loadTutors() async {
    await Future.delayed(const Duration(milliseconds: 1000));
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
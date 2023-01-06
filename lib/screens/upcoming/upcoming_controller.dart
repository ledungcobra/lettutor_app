import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../models/class_history/class_history.dart';

class UpcomingController extends GetxController with HandleUIError {
  final tutorService = Get.find<TutorService>();
  final bookingItems = <ClassHistory>[].obs;
  num page = 1;
  final num perPage = 5;

  final StateSetter setState;

  UpcomingController(this.setState);

  refreshState() {
    setState(() {});
  }

  loadNextUpcoming() async {
    print("Page = $page perPage = $perPage");
    var response = await tutorService.getUpComings(perPage, page);
    if (response.hasError) {
      handleError(response.error!);
      return;
    }
    bookingItems.addAll(response.data!);
    page++;
  }

  handleUpdateRequest(String reportText, String? bookingId) async {
    var success = await tutorService.editBookingRequest(reportText, bookingId);
    Get.back();
    if (success) {
      Get.snackbar(
        'Success',
        'Updated request to the tutor',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      var index = bookingItems.indexWhere((element) => element.id == bookingId);
      bookingItems[index].studentRequest = reportText;
      bookingItems.refresh();
    } else {
      Get.snackbar(
        'Error',
        'Error to update this request',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  handleCancel(String reportText, String? bookingId, int selectedReason) async {
    if (selectedReason == 0) {
      Get.snackbar(
        'Error',
        'Please select reason',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    var response = await tutorService.cancelBookingRequest(
        bookingId, selectedReason, reportText);
    if (response.hasData) {
      Get.back(result: true);
      Get.snackbar(
        'Success',
        response.data,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      bookingItems.value =
          bookingItems.where((item) => item.id != bookingId).toList();
      refreshState();
    } else {
      Get.back(result: true);
      Get.snackbar(
        'Error',
        response.error?.message ?? "",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  refreshUpcoming() async {
    page = 1;
    bookingItems.clear();
    await loadNextUpcoming();
  }
}

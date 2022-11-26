import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../models/booking_item.dart';

class UpcomingController extends GetxController with HandleUIError {
  final tutorService = Get.find<TutorService>();
  final bookingItems = <BookingItem>[].obs;

  loadData() async {
    var response = await tutorService.getUpcomingCourse();
    if (response.hasError) {
      handleError(response.error!);
      return;
    }
    bookingItems.value = response.data!;
  }

  handleUpdateRequest(String reportText, BookingItem bookingItem) async {
    var success =
        await tutorService.editBookingRequest(reportText, bookingItem.id);
    Get.back();
    if (success) {
      Get.snackbar(
        'Success',
        'Updated request to the tutor',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      var index = bookingItems.indexWhere((element) => element.id == bookingItem.id);
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

  handleCancel(String reportText, BookingItem bookingItem, int selectedReason) async {
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
        bookingItem.id!, selectedReason, reportText);
    if (response.hasData) {
      Get.back(result: true);
      Get.snackbar(
        'Success',
        response.data,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      bookingItems.value = bookingItems.where((item)=> item.id != bookingItem.id).toList();
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

}

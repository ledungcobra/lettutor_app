import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/booking_item.dart';
import 'package:lettutor_app/screens/upcoming/widgets/request_edit_dialog.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/button.dart';

import '../../../services/tutor_service.dart';
import '../../video_call/jitsy_util.dart';
import 'cancel_dialog.dart';

class UpcomingItem extends StatelessWidget {
  final BookingItem bookingItem;
  final tutorService = Get.find<TutorService>();

  ScheduleInfo? get scheduleInfo =>
      bookingItem.scheduleDetailInfo?.scheduleInfo;

  UpcomingItem({Key? key, required this.bookingItem}) : super(key: key);

  _messageNow() {}

  _handleCancelUpcoming() async {
    Get.dialog(CancelDialog(bookingItem: bookingItem));
  }

  _handleGoMeeting() async {
    await joinMeetingJitsi(bookingItem);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(scheduleInfo?.date ?? "Date not found"),
                  Text('${scheduleInfo?.startTime}-${scheduleInfo?.endTime!}')
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      NetworkAvatar(url: scheduleInfo?.tutorInfo?.avatar),
                      SizedBox(
                        height: 2,
                      ),
                      Text(scheduleInfo?.tutorInfo?.country ??
                          "Not found country"),
                      SizedBox(
                        height: 2,
                      ),
                      IconButton(
                          onPressed: _messageNow,
                          icon: Icon(Icons.message_outlined,
                              color: PRIMARY_COLOR))
                    ],
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          Container(
                            height: 45,
                            color: Get.isDarkMode ? null : Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.keyboard_arrow_down),
                                      Text(
                                        'Request for lesson',
                                        style: TextStyle(fontSize: 13),
                                      )
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.dialog(
                                        RequestEditDialog(
                                            bookingItem: bookingItem),
                                      );
                                    },
                                    child: Text(
                                      'Edit Request',
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                bookingItem.studentRequest ??
                                    'Currently there no requests for this class. Please write down any request for the teacher',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Button(
                    full: false,
                    radius: 10,
                    title: 'Cancel',
                    onClick: _handleCancelUpcoming,
                    color: Get.theme.accentColor,
                  ),
                  SizedBox(width: 20),
                  Button(
                    full: false,
                    radius: 10,
                    title: 'Go Meeting',
                    onClick: _handleGoMeeting,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

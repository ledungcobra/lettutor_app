import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_app/screens/upcoming/widgets/request_edit_dialog.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/button.dart';

import '../../../models/class_history/class_history.dart';
import '../../../models/class_history/schedule_detail_info.dart';
import '../../../models/class_history/schedule_info.dart';
import '../../../services/tutor_service.dart';
import '../../chat_screen/chat_screen.dart';
import '../../video_call/jitsy_util.dart';
import 'cancel_dialog.dart';

class UpcomingItem extends StatelessWidget {
  final ClassHistory bookingItem;
  final tutorService = Get.find<TutorService>();
  final dateFormat = Get.find<DateFormat>();

  ScheduleDetailInfo? get scheduleDetailInfo => bookingItem.scheduleDetailInfo;

  ScheduleInfo? get scheduleInfo => scheduleDetailInfo?.scheduleInfo;

  UpcomingItem({Key? key, required this.bookingItem}) : super(key: key);

  _messageNow() {
    Get.to(() => ChatScreen(userId: bookingItem.userId));
  }

  _handleCancelUpcoming() async {
    Get.dialog(CancelDialog(bookingItem: bookingItem));
  }

  _handleGoMeeting() async {
    await joinMeetingJitsi(bookingItem.studentMeetingLink ?? "");
  }

  String getPeriod() {
    final start = DateTime.fromMillisecondsSinceEpoch(
        scheduleDetailInfo?.startPeriodTimestamp ?? 0);
    final end = DateTime.fromMillisecondsSinceEpoch(
        scheduleDetailInfo?.endPeriodTimestamp ?? 0);
    return '${start.hour.toTwoDigit()}:${start.minute.toTwoDigit()} - ${end.hour.toTwoDigit()}:${end.minute.toTwoDigit()}';
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
                children: [Text(scheduleInfo?.date ?? ''), Text(getPeriod())],
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
                              color: Get.theme.primaryColor))
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
                                          bookingId: bookingItem.id,
                                          studentRequest:
                                              bookingItem.studentRequest,
                                        ),
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
                  if (bookingItem.cancelReasonId == null)
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

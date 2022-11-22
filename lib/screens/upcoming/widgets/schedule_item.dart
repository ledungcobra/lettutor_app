import 'package:flutter/material.dart';
import 'package:lettutor_app/models/schedule.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/button.dart';

class MeetingItem extends StatelessWidget {
  final Schedule schedule;

  const MeetingItem({Key? key, required this.schedule}) : super(key: key);

  _messageNow() {}

  _handleCancelUpcoming() {}

  _handleGoMeeting() {}

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
                  Text(schedule.date!),
                  Text('${schedule.startTime!}-${schedule.endTime!}')
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      NetworkAvatar(url: schedule.teacherInfo!.avatar!),
                      SizedBox(
                        height: 2,
                      ),
                      Text(schedule.teacherInfo!.nationality!),
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
                            color: Colors.grey[100],
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
                                    onPressed: () {},
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
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Currently there no requests for this class. Please write down any request for the teacher',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
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
                    color: Colors.red,
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

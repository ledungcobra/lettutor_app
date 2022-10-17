import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lettutor_app/models/schedule.dart';
import 'package:lettutor_app/screens/upcoming/widgets/schedule_item.dart';
import 'package:lettutor_app/services/user_service.dart';

class UpcomingScreen extends StatelessWidget {
  late UserService userService;

  UpcomingScreen({Key? key}) : super(key: key) {
    userService = GetIt.I.get<UserService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upcoming')),
      backgroundColor: Colors.grey[200],
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: _listSchedule(),
        ),
      ),
    );
  }

  Widget _listSchedule() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var schedules = snapshot.data as List<Schedule>;
          return ListView(
            children: schedules.map((schedule)=> MeetingItem(schedule: schedule)).toList(),
          );
        }
        if (snapshot.hasError) {
          return Container();
        }
        return CircularProgressIndicator();
      },
      future: userService.getListSchedules(),
    );
  }

  Future<void> _showMyDialog(context, target, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('An error occur when loading $target'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

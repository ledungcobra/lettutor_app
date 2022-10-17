import 'package:flutter/material.dart';
import 'package:lettutor_app/screens/history/history_screen.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/button.dart';

class SettingsScreen extends StatelessWidget with Dimension {
  late BuildContext context;

  SettingsScreen({Key? key}) : super(key: key);

  _handleLogout() {}

  _handleOpenHistory() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => HistoryScreen()));
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _userDetails(),
            SizedBox(height: 100,),
            Button(
              title: 'Booking History',
              onClick: _handleOpenHistory,
              color: Colors.white,
              textColor: Colors.black54,
              leadingIcon: Icon(
                Icons.history,
                color: Colors.black,
              ),
              radius: 50,
            ),
            SizedBox(
              height: 5,
            ),
            Button(
              title: 'Logout',
              onClick: _handleLogout,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }

  _userDetails() {
    return Row(
      children: [
        NetworkAvatar(url: ''),
        SizedBox(width: 20,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Name', style: TextStyle(fontSize: 18),),
            Text("Email@gmail.com", style: TextStyle(fontSize: 18),),
          ],
        )
      ],
    );
  }
}

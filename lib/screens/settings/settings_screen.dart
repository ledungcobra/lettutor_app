import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/user_info.dart';
import 'package:lettutor_app/screens/history/history_screen.dart';
import 'package:lettutor_app/screens/login/login_screen.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/button.dart';

class SettingsScreen extends StatefulWidget with Dimension {

  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late BuildContext context;

  UserInfo? userInfo;

  @override
  void initState() {
    Get.find<UserService>()
        .getUserInfo()
        .then((value) => setState(() {
      userInfo = value;
    }))
        .catchError((e) => print(e.toString()));
    super.initState();
  }

  void _handleLogout() {
    Get.offAll(LoginScreen());
  }

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
            SizedBox(
              height: 100,
            ),
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
        NetworkAvatar(url: userInfo?.user?.avatar ?? DEFAULT_AVATAR),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              userInfo?.user?.name ?? "",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              userInfo?.user?.email ?? "",
              style: TextStyle(fontSize: 18),
            ),
          ],
        )
      ],
    );
  }
}

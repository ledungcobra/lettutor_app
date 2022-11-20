import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/history/history_screen.dart';
import 'package:lettutor_app/screens/login/login_screen.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/shared_reference.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/button.dart';

class SettingsScreen extends StatelessWidget {
  final tokenService = Get.find<TokenService>();
  final userService = Get.find<UserService>();

  SettingsScreen({Key? key}) : super(key: key);

  void _handleLogout() async {
    await tokenService.clearTokens();
    Get.offAll(LoginScreen());
  }

  _handleOpenHistory() {
    Get.to(HistoryScreen());
  }

  @override
  Widget build(BuildContext context) {
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
        NetworkAvatar(url: userService.userInfo.user?.avatar ?? DEFAULT_AVATAR),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              userService.userInfo.user?.name ?? "",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              userService.userInfo.user?.email ?? "",
              style: TextStyle(fontSize: 18),
            ),
          ],
        )
      ],
    );
  }
}

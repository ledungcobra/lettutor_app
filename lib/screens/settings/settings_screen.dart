import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/history/history_screen.dart';
import 'package:lettutor_app/screens/login/login_screen.dart';
import 'package:lettutor_app/screens/profile/profile_screen.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/shared_reference.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/theme_controller.dart';
import '../become_teacher/become_tutor_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final tokenService = Get.find<TokenService>();
  final userService = Get.find<UserService>();
  final themeController = Get.find<ThemeController>();

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
        title: Text('Settings', style: Get.theme.textTheme.bodyText1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _userDetails(),
              SizedBox(
                height: 100,
              ),
              historyBtn(),
              divider(),
              becomeTutorBtn(),
              divider(),
              darkModeBtn(),
              divider(),
              profileBtn(),
              divider(),
              logoutBtn()
            ],
          ),
        ),
      ),
    );
  }

  Widget profileBtn() {
    return Button(
      title: 'Profile',
      onClick: () => Get.to(ProfileScreen()),
      color: Get.isDarkMode ? Colors.black : Get.theme.primaryColor,
      leadingIcon: Icon(
        Icons.people,
        color: Get.isDarkMode ? Colors.white : Colors.black45,
      ),
    );
  }

  Widget becomeTutorBtn() {
    return Button(
      title: 'Become tutor',
      onClick: () => Get.to(BecomeTutorScreen()),
      color: Get.isDarkMode ? Colors.black : Get.theme.primaryColor,
      leadingIcon: Icon(
        Icons.school,
        color: Get.isDarkMode ? Colors.white : Colors.black45,
      ),
    );
  }

  SizedBox divider() {
    return SizedBox(
      height: 5,
    );
  }

  Button logoutBtn() {
    return Button(
      title: 'Logout',
      onClick: _handleLogout,
      color: !Get.isDarkMode ? Colors.white10 : Colors.blueGrey,
    );
  }

  Widget darkModeBtn() {
    return Button(
      title: themeController.isLight.value ? 'Dark mode' : 'Light mode',
      onClick: () async {
        Get.changeThemeMode(
          Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
        );
        themeController.toggle();
        await themeController.saveThemeStatus();
      },
      color: Get.isDarkMode ? Colors.black : Get.theme.primaryColor,
      // textColor: Colors.black54,
      leadingIcon: Icon(
        themeController.isLight.value ? Icons.dark_mode : Icons.light_mode,
        color: Get.isDarkMode ? Colors.white : Colors.black45,
      ),
    );
  }

  Widget historyBtn() {
    return Button(
      title: 'Booking History',
      onClick: _handleOpenHistory,
      color: Get.isDarkMode ? Colors.black : Get.theme.primaryColor,
      // textColor: Colors.black54,
      leadingIcon: Icon(
        Icons.history,
        color: Get.isDarkMode ? Colors.white : Colors.black45,
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

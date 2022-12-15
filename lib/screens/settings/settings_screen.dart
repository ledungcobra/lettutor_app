import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/history/history_screen.dart';
import 'package:lettutor_app/screens/login/login_screen.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/shared_reference.dart';
import 'package:lettutor_app/widgets/avatar.dart';
import 'package:lettutor_app/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {

  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final tokenService = Get.find<TokenService>();
  final userService = Get.find<UserService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getThemeStatus();
  }
  void _handleLogout() async {
    await tokenService.clearTokens();
    Get.offAll(LoginScreen());
  }

  _handleOpenHistory() {
    Get.to(HistoryScreen());
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _isLightTheme = false.obs;

  _saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', _isLightTheme.value);
  }

  _getThemeStatus() async {
    var _isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') != null ? prefs.getBool('theme') : true;
    }).obs;
    _isLightTheme.value = await _isLight.value ?? true;
    Get.changeThemeMode(_isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
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
            ObxValue(
              (data) => Switch(
                value: _isLightTheme.value,
                onChanged: (val) {
                  _isLightTheme.value = val;
                  Get.changeThemeMode(
                    _isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
                  );
                  _saveThemeStatus();
                },
              ),
              false.obs,
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

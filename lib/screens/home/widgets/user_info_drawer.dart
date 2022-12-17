import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/user_info.dart';
import 'package:lettutor_app/screens/profile/profile_screen.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/widgets/avatar.dart';

class UserInfoDrawer extends StatelessWidget {
  final userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration:  BoxDecoration(
              color: Get.isDarkMode ? Colors.black45: Get.theme.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NetworkAvatar(url: userService.userInfo.user?.avatar ?? ""),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userService.userInfo.user?.name ?? "",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(userService.userInfo.user?.email ?? "",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person_outline_sharp,
              // color: Colors.black,
              size: 28,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              // Open Profile
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => ProfileScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.school,
              // color: Colors.black,
              size: 28,
            ),
            title: const Text(
              'Become Tutor',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {

              Get.snackbar('Notification', 'Becoming tutor',
                  backgroundColor: Colors.greenAccent);
            },
          )
        ],
      ),
    );
  }
}

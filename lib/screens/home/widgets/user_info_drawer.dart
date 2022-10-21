import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lettutor_app/models/user_info.dart';
import 'package:lettutor_app/screens/profile/profile_screen.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/widgets/avatar.dart';

class UserInfoDrawer extends StatefulWidget {
  UserInfoDrawer({Key? key}) : super(key: key);

  @override
  State<UserInfoDrawer> createState() => _UserInfoDrawerState();
}

class _UserInfoDrawerState extends State<UserInfoDrawer> {
  UserInfo? userInfo;

  @override
  void initState() {
    GetIt.I
        .get<UserService>()
        .getUserInfo()
        .then((value) => setState(() {
              userInfo = value;
            }))
        .catchError((e) => print(e.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: PRIMARY_COLOR,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NetworkAvatar(url: userInfo?.user?.avatar ?? ""),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userInfo?.user?.name ?? "",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(userInfo?.user?.email ?? "",
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
              color: Colors.black,
              size: 28,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            onTap: () {
              // Open Profile
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ProfileScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.school,
              color: Colors.black,
              size: 28,
            ),
            title: const Text(
              'Become Tutor',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            onTap: () {
              // Become Tutor
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.menu_book,
              color: Colors.black,
              size: 28,
            ),
            title: const Text(
              'List of courses',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

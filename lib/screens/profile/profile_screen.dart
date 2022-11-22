import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/user_info.dart';
import 'package:lettutor_app/screens/profile/widgets/birthday_text_form_field.dart';
import 'package:lettutor_app/screens/profile/widgets/country_text_form_field.dart';
import 'package:lettutor_app/screens/profile/widgets/courses_text_form_field.dart';
import 'package:lettutor_app/screens/profile/widgets/edit_photo.dart';
import 'package:lettutor_app/screens/profile/widgets/email_text_form_field.dart';
import 'package:lettutor_app/screens/profile/widgets/level_text_form_field.dart';
import 'package:lettutor_app/screens/profile/widgets/normal_text_form_filed.dart';
import 'package:lettutor_app/screens/profile/widgets/phone_text_form_field.dart';
import 'package:lettutor_app/screens/profile/widgets/update_button.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/widgets/loading.dart';

class ProfileScreen extends StatefulWidget {

  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    if(userInfo == null){
      return Loading();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    EditPhoto( userInfo?.user),
                    Spacer(),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                   userInfo?.user?.name ?? "Unknown",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                NormalTextFormField(name:  userInfo?.user?.name ?? "Unknown", hintText: "Enter your name", title: "Name",),
                SizedBox(height: 10),
                EmailTextFormField(email: userInfo?.user?.email ?? ""),
                SizedBox(height: 10),
                CountryTextFormField(title: "Country"),
                SizedBox(height: 10),
                PhoneTextFormField(phoneNumber: userInfo?.user?.phone?? "Not available"),
                SizedBox(height: 10),
                BirthdayTextFormField(title: "Birthday", birthday: userInfo?.user?.birthday ?? ""),
                SizedBox(height: 10),
                LevelTextFormField(level: userInfo?.user?.level ?? ""),
                SizedBox(height: 10),
                CoursesTextFormField(title: "Self Description", hintText: "Self description",),
                SizedBox(height: 20),
                UpdateButton()
              ],
            ),
          ),
        ),
      )
    );
  }
}

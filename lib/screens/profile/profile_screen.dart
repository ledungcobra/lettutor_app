import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/category_list/category.dart';
import 'package:lettutor_app/models/user_info/user_info.dart';
import 'package:lettutor_app/screens/profile/profile_controller.dart';
import 'package:lettutor_app/screens/profile/widgets/birthday_text_form_field.dart';
import 'package:lettutor_app/screens/profile/widgets/country_text_form_field.dart';
import 'package:lettutor_app/screens/profile/widgets/courses_text_form_field.dart';
import 'package:lettutor_app/screens/profile/widgets/edit_photo.dart';
import 'package:lettutor_app/screens/profile/widgets/email_text_form_field.dart';
import 'package:lettutor_app/screens/profile/widgets/level_text_form_field.dart';
import 'package:lettutor_app/screens/profile/widgets/normal_text_form_filed.dart';
import 'package:lettutor_app/screens/profile/widgets/phone_text_form_field.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/services/utils_service.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/widgets/loading.dart';

import '../../widgets/button.dart';
import 'widgets/study_schdule_text_form_filed.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with HandleUIError {
  UserInfo? userInfo;
  final userService = Get.find<UserService>();
  final utilService = Get.find<UtilService>();

  @override
  void initState() {
    userService.getUserInfo().then((response) {
      if (response.hasError) {
        handleError(response.error!);
        return;
      }
      userInfo = response.data!;

      ProfileController profileController = ProfileController();
      Get.replace(profileController, tag: 'profile_controller');
      profileController.name.value = userInfo?.user?.name ?? "";
      profileController.country.value = userInfo?.user?.country ?? "";
      profileController.phone.value = userInfo?.user?.phone ?? "";
      profileController.birthday.value = userInfo?.user?.birthday ?? "";
      profileController.studySchedule.value =
          userInfo?.user?.studySchedule ?? '';
      profileController.level.value = userInfo?.user?.level ?? "";
      profileController.learnTopicsId.value =
          (userInfo?.user?.learnTopics ?? []).map((e) => '${e.id}').toList();
      profileController.testPreparationsId.value =
          (userInfo?.user?.testPreparations ?? [])
              .map((e) => '${e.id}')
              .toList();
      setState(() {});
    }).catchError((e) => print(e.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userInfo == null) {
      return Scaffold(body: Center(child: Loading()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
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
                    EditPhoto(),
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
                NameFormField(
                  hintText: "Enter your name",
                  title: "Name",
                ),
                SizedBox(height: 10),
                EmailTextFormField(email: userInfo?.user?.email ?? ""),
                SizedBox(height: 10),
                CountryTextFormField(
                    country: "Country",
                    onDone: (v) => controller.country.value = v.countryCode),
                SizedBox(height: 10),
                PhoneTextFormField(),
                SizedBox(height: 10),
                BirthdayTextFormField(
                    title: "Birthday",
                    birthday: userInfo?.user?.birthday,
                    onDone: (v) => controller.birthday.value = v),
                SizedBox(height: 10),
                SelectionTextFormField(
                    initField: userInfo?.user?.level ?? "",
                    categories: utilService.proficiencies,
                    onSelect: (category) =>
                        controller.level.value = category.key!),
                SizedBox(height: 10),
                CoursesTextFormField(
                  title: "Want to learn",
                  hintText: "What do want to learn",
                  selectedLearnTopics: (userInfo?.user?.learnTopics ?? [])
                      .map((x) => Category(
                          key: x.key, id: '${x.id}', description: x.name))
                      .toList(),
                  selectedTestPreparations:
                      (userInfo?.user?.testPreparations ?? [])
                          .map((x) => Category(
                              key: x.key, id: '${x.id}', description: x.name))
                          .toList(),
                  onDone: (learnTopics, testPreparations) {
                    controller.learnTopicsId.value =
                        learnTopics.map((e) => e.id!).toList();
                    controller.testPreparationsId.value =
                        testPreparations.map((e) => e.id!).toList();
                  },
                ),
                SizedBox(height: 20),
                StudyScheduleTextFormField(
                    hintText: "What you want to say?",
                    title: "Study Schedule",
                    value: controller.studySchedule.value),
                Button(
                  title: 'Update',
                  onClick: handleUpdateProfile,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ProfileController get controller =>
      Get.find<ProfileController>(tag: 'profile_controller');

  handleUpdateProfile() async {
    final controller = Get.find<ProfileController>(tag: 'profile_controller');
    var profileDto = controller.getProfileDto();
    await userService.updateProfile(profileDto);
    setState(() {});
    Get.snackbar('Notification', "Profile updated",
        backgroundColor: Colors.lightGreen);
  }
}

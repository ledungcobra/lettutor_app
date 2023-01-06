import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/become_teacher/sub_screen/step2.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../../services/tutor_service.dart';
import '../../../services/utils_service.dart';
import '../../../utils/types.dart';
import '../../../widgets/button.dart';
import '../become_tutor_controller.dart';
import '../widgets/birthday_text_form_field.dart';
import '../widgets/country_text_form_field.dart';
import '../widgets/courses_text_form_field.dart';
import '../widgets/edit_photo.dart';
import '../widgets/file_selector.dart';
import '../widgets/selection_text_form_field.dart';
import '../widgets/my_text_form_field.dart';

class Step1 extends StatelessWidget with HandleUIError {

  final UtilService utilService = Get.find<UtilService>();
  final tutorService = Get.find<TutorService>();
  final loading = false.obs;
  final success = false.obs;

  void becomeTeacher() async {
    try {
      loading.value = true;
      final response =
          await tutorService.performBecomeATeacher(await controller.buildDto());
      loading.value = false;
      if (response.hasError) {
        handleError(response.error!);
        return;
      }
      success.value = true;
    } on FormValidationException catch (e) {
      handleError(e.error);
    }
  }

  BecomeTutorController get controller =>
      Get.find<BecomeTutorController>(tag: 'become_tutor_controller');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditPhoto(onDone: (v) => controller.avatar = v),
        SizedBox(height: 20),
        MyTextFormField(
          onDone: (v) => controller.name = v,
          placeHolder: 'Tutor name',
        ),
        SizedBox(height: 20),
        CountryTextFormField(
          onDone: (v) => controller.country = v.countryCode,
          name: 'Where are you come from?',
        ),
        SizedBox(height: 20),
        BirthdayTextFormField(
          onDone: (v) => controller.birthday = v,
          title: 'Date of Birth',
        ),
        SizedBox(height: 20),
        MyTextFormField(
            onDone: (v) => controller.interests = v, placeHolder: 'Interests'),
        SizedBox(height: 20),
        MyTextFormField(
            onDone: (v) => controller.education = v, placeHolder: 'Education'),
        MyTextFormField(
            onDone: (v) => controller.experience = v,
            placeHolder: 'Experience'),
        SizedBox(height: 20),
        MyTextFormField(
            onDone: (v) => controller.profession = v,
            placeHolder: 'Profession'),
        SizedBox(height: 20),
        MultipleSelectionFormField(
          hintText: 'Select your languages',
          title: 'Your languages',
          onDone: (v) => controller.languages = v.map((e) => e.key).join(","),
          initValues: [],
          specialties: utilService.languages,
        ),
        SizedBox(height: 20),
        MyTextFormField(
            onDone: (v) => controller.bio = v, placeHolder: 'Who I teach'),
        SizedBox(height: 20),
        SelectionTextFormField(
          initSelected: 'BEGINNER',
          categories: utilService.proficiencies,
          onSelect: (v) => controller.targetStudent = v.key ?? "",
          placeHolder: 'I am best at teaching students who are',
        ),
        SizedBox(height: 20),
        MultipleSelectionFormField(
          hintText: 'Your specialties are',
          title: 'Your specialties',
          onDone: (v) => controller.specialties = v.map((e) => e.key).join(','),
          initValues: [],
          specialties: utilService.specialties,
        ),
        SizedBox(height: 20),
        FileSelector(
          onDone: (v) => controller.certificate = v,
          placeHolder: 'Certificate',
        ),
        SizedBox(height: 20),
        VideoStep(),
        Button(
          title: 'Become teacher',
          onClick: becomeTeacher,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/widgets/avatar.dart';

import '../become_tutor_controller.dart';

class EditPhoto extends StatefulWidget {

  EditPhoto({
    Key? key,
  }) : super(key: key);

  @override
  State<EditPhoto> createState() => _EditPhotoState();
}

class _EditPhotoState extends State<EditPhoto> {
  get controller => Get.find<BecomeTutorController>(tag: 'become_tutor_controller');
  final ImagePicker _picker = ImagePicker();
  get user => Get.find<UserService>().userInfo.user;

  Future getImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    await controller.uploadAvatar(image);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(75.0),
          child: NetworkAvatar(
              url: user?.avatar ?? "", width: 200, height: 200),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: ElevatedButton(
            onPressed: getImageFromGallery,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              // padding: EdgeInsets.all(),
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
            child: const Icon(Icons.edit),
          ),
        )
      ],
    );
  }
}

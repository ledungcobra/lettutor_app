import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/utils/helper.dart';


class EditPhoto extends StatefulWidget {

  final Function(String path) onDone;

  EditPhoto({
    Key? key, required this.onDone,
  }) : super(key: key);

  @override
  State<EditPhoto> createState() => _EditPhotoState();
}

class _EditPhotoState extends State<EditPhoto> {
  final ImagePicker _picker = ImagePicker();
  var avatarPath = getAssetImage("intro_photo.png").obs;
  var selected = false.obs;
  Rxn<File> imageFile = Rxn();

  Future getImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    imageFile.value = File(image.path);
    selected.value = true;
    widget.onDone(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(75.0),
              child: Obx(
                () => !selected.value || imageFile.value == null
                    ? Image.asset(
                        avatarPath.value,
                        width: Get.width * 0.5,
                        height: Get.width * 0.5,
                        fit: BoxFit.fill,
                      )
                    : Image.file(
                        imageFile.value!,
                        width: Get.width * 0.5,
                        height: Get.width * 0.5,
                        fit: BoxFit.fill,
                      ),
              ),
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
        ),
      ],
    );
  }
}

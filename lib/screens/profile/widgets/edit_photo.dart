import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/models/user_info.dart';
import 'package:lettutor_app/widgets/avatar.dart';

class EditPhoto extends StatefulWidget {
  User? user;
  EditPhoto(this.user, {
    Key? key,
  }) : super(key: key);
  @override
  State<EditPhoto> createState() => _EditPhotoState();
}

class _EditPhotoState extends State<EditPhoto> {
  String imageURI = "";
  final ImagePicker _picker = ImagePicker();
  Future getImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(75.0),
          child: imageURI != ""
              ? Image.file(File(imageURI),
                  width: 200, height: 200, fit: BoxFit.fill)
              : NetworkAvatar(url: widget.user?.avatar ?? "",
                  width: 200, height: 200),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: ElevatedButton(
            onPressed: getImageFromGallery,
            child: const Icon(Icons.edit),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              // padding: EdgeInsets.all(),
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

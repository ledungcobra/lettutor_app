import 'package:avatars/avatars.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart' as p;
import 'package:get/get.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/helper.dart';

class NetworkAvatar extends StatelessWidget {
  final dio = Get.find<Dio>();
  final String? url;
  final double width;
  final double height;

  NetworkAvatar({Key? key, this.url, this.width = 50, this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url ==
        'https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png') {
      return SizedBox(
          width: width,
          height: height,
          child: Avatar(
            loader: Image.asset(getAssetImage('not_found.png')),
            useCache: true,
            sources: [NetworkSource(DEFAULT_AVATAR)],
          ));
    }
    return p.ProfilePicture(
      radius: width / 2,
      fontsize: (height - 2) / 2,
      img: url,
      name: 'empty',
    );
  }
}

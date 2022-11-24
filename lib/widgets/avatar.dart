import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_app/utils/constants.dart';

class NetworkAvatar extends StatelessWidget {
  final String? url;
  final double width;
  final double height;

  const NetworkAvatar({Key? key, this.url, this.width = 50, this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child:Avatar(
        useCache: true,
        sources: [
          NetworkSource(url ?? DEFAULT_AVATAR),
          NetworkSource(DEFAULT_AVATAR)
        ],
      )
    );
  }
}

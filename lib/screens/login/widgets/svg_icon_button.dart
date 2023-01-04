import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/helper.dart';

class SvgIconButton extends StatelessWidget {
  late String image;
  Function? onClick;

  SvgIconButton({required this.image, this.onClick});

  @override
  Widget build(BuildContext context) {
    var url = getAssetImage(image);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          if (onClick != null) {
            onClick!();
          }
        },
        borderRadius: BorderRadius.circular(50),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: PRIMARY_COLOR,
              ),
              shape: BoxShape.circle),
          child: SvgPicture.asset(
            url,
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}

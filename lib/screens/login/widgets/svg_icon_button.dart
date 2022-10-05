import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_app/utils/constants.dart';

class SvgIconButton extends StatelessWidget {
  late String _imageName;

  SvgIconButton(String assetImage) {
    _imageName = assetImage;
  }

  @override
  Widget build(BuildContext context) {
    var url = getAssetImage(_imageName);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          print('Taped');
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

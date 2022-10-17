import 'package:flutter/material.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/mixing.dart';

class Button extends StatelessWidget with Dimension {
  final VoidCallback onClick;
  final String title;
  Color color;
  Color textColor;
  double radius;
  bool full;
  late EdgeInsetsGeometry padding;
  double? btnWidth;
  Icon? leadingIcon;

  Button(
      {Key? key,
      required this.title,
      required this.onClick,
      this.color = PRIMARY_COLOR,
      this.textColor = Colors.white,
      this.radius = 0,
      this.full = true,
      this.leadingIcon})
      : super(key: key) {
    padding = EdgeInsets.symmetric(vertical: 1, horizontal: 8);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      minWidth: full
          ? MediaQuery.of(context).size.width
          : btnWidth != null
              ? btnWidth!
              : 0,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: color,
      onPressed: onClick,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null)
              Container(
                margin: EdgeInsets.only(right: 10),
                child: leadingIcon!,
              ),
            Text(title, style: TextStyle(color: textColor, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

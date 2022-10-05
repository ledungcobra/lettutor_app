import 'package:flutter/material.dart';
import 'package:lettutor_app/utils/constants.dart';

class Button extends StatelessWidget {
  final VoidCallback onClick;
  final String title;
  Color color;

  Button(
      {Key? key,
      required this.title,
      required this.onClick,
      this.color = PRIMARY_COLOR})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: PRIMARY_COLOR,
      onPressed: onClick,
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}

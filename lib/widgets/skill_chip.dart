import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SkillChip extends StatelessWidget {
  SkillChip({
    Key? key,
    required this.selected,
    required this.value,
    this.onClick,
  }) : super(key: key);

  final bool selected;
  final String value;
  VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    Color? color;
    if(selected) {
      color = Get.isDarkMode ? Colors.black: Colors.blue[200];
    }
    return InkWell(
      onTap: () {
        if (onClick != null) onClick!();
      },
      child: Chip(
        backgroundColor: color,
        label:
            Text(value, style: selected ? Get.theme.textTheme.button : null),
      ),
    );
  }
}

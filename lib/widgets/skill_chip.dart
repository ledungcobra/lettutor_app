import 'package:flutter/material.dart';

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
    return InkWell(
      onTap: () {
        if (onClick != null) onClick!();
      },
      child: Chip(
        backgroundColor: selected ? Colors.blue[200] : null,
        label:
            Text(value, style: selected ? TextStyle(color: Colors.blue) : null),
      ),
    );
  }
}

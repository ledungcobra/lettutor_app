
import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  const SkillChip({
    Key? key,
    required this.selected,
    required this.value,
  }) : super(key: key);

  final bool selected;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: selected ? Colors.blue[200]: null,
      label: Text(value, style: selected ? TextStyle(color: Colors.blue): null),
    );
  }
}

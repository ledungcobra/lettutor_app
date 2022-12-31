import 'package:flutter/material.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../../models/course/topic.dart';

class TopicItem extends StatelessWidget with Dimension {

  final Topic topics;
  final bool isSelected;
  final int position;
  final void Function(int index) changeSelectedIndex;

  const TopicItem(
      {Key? key,
      required this.topics,
      required this.isSelected,
      required this.position,
      required this.changeSelectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changeSelectedIndex(position - 1),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isSelected ? Colors.grey[300] : Colors.white),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          margin: EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              Text(
                '${position}. ${topics.name}',
                textAlign: TextAlign.start,
              ),
            ],
          )),
    );
  }
}

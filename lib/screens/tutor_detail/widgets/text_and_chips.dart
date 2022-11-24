import 'package:flutter/material.dart';
import 'package:lettutor_app/models/category_items.dart';
import 'package:lettutor_app/utils/constants.dart';

class TextAndChips extends StatelessWidget {
  const TextAndChips({
    Key? key,
    required this.text,
    required this.chips,
  }) : super(key: key);
  final String text;
  final List<Category> chips;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: PRIMARY_COLOR),
          ),
          const SizedBox(height: 5),
          Wrap(
            children: List.generate(
              chips.length,
                  (index) => Chip(
                label: Text(
                  chips[index].description ?? "",
                  style: const TextStyle(color: PRIMARY_COLOR, fontSize: 12),
                ),
                backgroundColor: CHIP_COLOR,
              ),
            ),
          ),

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'title_line.dart';


class StepTwoContent extends StatelessWidget {
  const StepTwoContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const TitleLine(title: "Introduction video"),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("A few helpful tips:"),
              Text("1. Find a clean and quiet space"),
              Text("2. Smile and look at the camera"),
              Text("3. Dress smart"),
              Text("4. Speak for 1-3 minutes"),
              Text("5. Brand yourself and have fun!"),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () {}, child: const Text("Choose video"),)
      ],
    );
  }
}

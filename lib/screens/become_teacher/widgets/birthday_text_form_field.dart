import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../become_tutor_controller.dart';

class BirthdayTextFormField extends StatefulWidget {
  
  final String title;
  String? birthday;
  Function(String v) onDone;
  BirthdayTextFormField({Key? key, required this.title, this.birthday, required  this.onDone})
      : super(key: key);

  @override
  State<BirthdayTextFormField> createState() => _BirthdayTextFormFieldState();
}

class _BirthdayTextFormFieldState extends State<BirthdayTextFormField> {

  TextEditingController textController = TextEditingController();
  final controller = Get.find<BecomeTutorController>(tag: 'become_tutor_controller');

  @override
  void initState() {
    textController.addListener(() {
      widget.onDone(textController.text);
    });
    textController.text = widget.birthday != null && widget.birthday!.isNotEmpty
        ? DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.birthday!))
        :  DateFormat('yyyy-MM-dd').format(DateTime.now()); //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: textController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(
                  2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101),
            );

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              setState(() {
                textController.text =
                    formattedDate; //set output date to TextField value.
              });
            }
          },
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/services/utils_service.dart';

import '../../../models/category_list/category.dart';


class CoursesTextFormField extends StatefulWidget {
  final List<Category> selectedLearnTopics;
  final List<Category> selectedTestPreparations;
  final Function(List<Category> selectedLearnTopics,
      List<Category> selectedPreparations) onDone;

  CoursesTextFormField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.selectedLearnTopics,
    required this.selectedTestPreparations,
    required this.onDone,
  }) : super(key: key);
  final String title;
  final String hintText;

  @override
  State<CoursesTextFormField> createState() => _CoursesTextFormFieldState();
}

class _CoursesTextFormFieldState extends State<CoursesTextFormField> {
  final utilService = Get.find<UtilService>();
  List<Category> selectedLearnTopics = [];
  List<Category> selectedTestPreparations = [];

  var textController = TextEditingController();

  @override
  void initState() {
    selectedLearnTopics = widget.selectedLearnTopics;
    selectedTestPreparations = widget.selectedTestPreparations;
    buildSelectionText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        TextFormField(
          controller: textController,
          readOnly: true,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: widget.hintText,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  title: const Text(
                      "Select subject \nTest preparation you want to learn"),
                  content: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          ...learnTopicsList(setState),
                          ...testPreparationList(setState)
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        buildSelectionText();
                        widget.onDone(selectedLearnTopics, selectedTestPreparations);
                      },
                      child: const Text("Ok"),
                    ),
                  ],
                );
              });
            },
          ),
        ),
      ],
    );
  }

  List<CheckboxListTile> learnTopicsList(StateSetter setState) {
    return utilService.learnTopics.values
        .map(
          (e) => CheckboxListTile(
            value: selectedLearnTopics.contains(e),
            onChanged: (value) {
              setState(() {
                if (value!) {
                  selectedLearnTopics.add(e);
                } else {
                  selectedLearnTopics.removeWhere((element) => element == e);
                }
              });
            },
            title: Text(e.description ?? ""),
          ),
        )
        .toList();
  }

  List<CheckboxListTile> testPreparationList(StateSetter setState) {
    return utilService.testPreparations.values
        .map(
          (e) => CheckboxListTile(
            value: selectedTestPreparations.contains(e),
            onChanged: (value) {
              setState(() {
                if (value!) {
                  selectedTestPreparations.add(e);
                } else {
                  selectedTestPreparations
                      .removeWhere((element) => element == e);
                }
              });
            },
            title: Text(e.description ?? ""),
          ),
        )
        .toList();
  }

  buildSelectionText() {
    textController.text = "";
    for (var i = 0; i < selectedLearnTopics.length; i++) {
      textController.text += "${selectedLearnTopics[i].description ?? ""}, ";
    }
    for (var i = 0; i < selectedTestPreparations.length; i++) {
      textController.text +=
          "${selectedTestPreparations[i].description ?? ""}, ";
    }
  }
}

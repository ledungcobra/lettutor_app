import 'package:flutter/material.dart';

import '../../../models/category_list/category.dart';

class MultipleSelectionFormField extends StatefulWidget {
  final List<Category> initValues;
  final Map<String?, Category> specialties;
  final Function(List<Category> selectedLanguages) onDone;

  const MultipleSelectionFormField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.initValues,
    required this.onDone,
    required this.specialties,
  }) : super(key: key);
  final String title;
  final String hintText;

  @override
  State<MultipleSelectionFormField> createState() =>
      _MultipleSelectionFormFieldState();
}

class _MultipleSelectionFormFieldState
    extends State<MultipleSelectionFormField> {

  List<Category> selectedSpecialties = [];

  var textController = TextEditingController();

  @override
  void initState() {
    selectedSpecialties = widget.initValues;
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
                fontWeight: FontWeight.bold,
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
                  title: const Text("Select your languages"),
                  content: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          ...specialtiesList(setState),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        buildSelectionText();
                        widget.onDone(selectedSpecialties);
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

  List<CheckboxListTile> specialtiesList(StateSetter update) {
    return widget.specialties.values
        .map(
          (e) => CheckboxListTile(
            value: selectedSpecialties.contains(e),
            onChanged: (value) {
              update(() {
                if (value!) {
                  selectedSpecialties.add(e);
                } else {
                  selectedSpecialties.removeWhere((element) => element == e);
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
    for (var i = 0; i < selectedSpecialties.length; i++) {
      textController.text += "${selectedSpecialties[i].description ?? ""}, ";
    }
  }
}

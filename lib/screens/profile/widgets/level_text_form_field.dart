import 'package:flutter/material.dart';
import '../../../models/category_list/category.dart';

class SelectionTextFormField extends StatefulWidget {
  final String? initField;
  final Map<String?, Category> categories;
  final Function(Category) onSelect;

  SelectionTextFormField({
    Key? key,
    required this.initField,
    required this.categories,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<SelectionTextFormField> createState() => _SelectionTextFormFieldState();
}

class _SelectionTextFormFieldState extends State<SelectionTextFormField> {
  final textController = TextEditingController();

  Category? selectedCategory;

  onSelect(Category category, {StateSetter? onComplete}) {
    textController.text = category.description ?? "";
    if(onComplete != null){
      onComplete!(() {
        selectedCategory = category;
      });
    }
    widget.onSelect(category);
  }

  @override
  void initState() {
    print(textController.text);
    if (widget.initField != null && widget.initField!.isNotEmpty) {
      onSelect(widget.categories[widget.initField?.toUpperCase()]!);
    } else {
      onSelect(widget.categories.values.first);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "Level",
              style: TextStyle(
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
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter level",
          ),
          onChanged: (v) => widget.onSelect(widget.categories[v]!),
          onSaved: (v) => widget.onSelect(widget.categories[v]!),
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
                  title: const Text("Select your level"),
                  content: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: widget.categories.values
                            .map(
                              (e) => RadioListTile<Category>(
                                value: e,
                                title: Text(e.description ?? ''),
                                groupValue: selectedCategory,
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    onSelect(newValue, onComplete: setState);
                                  }
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
            },
          ),
        ),
      ],
    );
  }
}

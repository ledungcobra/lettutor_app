import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';

class LanguageTextFormField extends StatefulWidget {
  const LanguageTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  State<LanguageTextFormField> createState() => _LanguageTextFormFieldState();
}

class _LanguageTextFormFieldState extends State<LanguageTextFormField> {
  var _selectedLanguage = TextEditingController();
  List languages = [];
  @override
  void initState() {
    _selectedLanguage.text = "";
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
              "My Level",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _selectedLanguage,
          keyboardType: TextInputType.none,
          readOnly: true,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Select your language",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          onTap: () {_openLanguagePickerDialog();},
        ),
      ],
    );
  }

  void _openLanguagePickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: LanguagePickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: const Text('Select your language'),
            onValuePicked: (Language language) => setState(
              () {
                _selectedLanguage.text = language.name;
              },
            ),
          ),
        ),
      );
}

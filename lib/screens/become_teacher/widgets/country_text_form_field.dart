import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CountryTextFormField extends StatefulWidget {
  final Function(Country) onDone;
  final String name;

  const CountryTextFormField({
    Key? key, required this.name, required this.onDone,
  }) : super(key: key);

  @override
  State<CountryTextFormField> createState() => _CountryTextFormFieldState();
}

class _CountryTextFormFieldState extends State<CountryTextFormField> {

  TextEditingController countryName = TextEditingController();
  Country? country;

  @override
  void initState() {
    countryName.text = "";
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
              widget.name,
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
          controller: countryName,
          readOnly: true,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter your country",
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          onSaved: (val) {},
          onTap: () {
            showCountryPicker(
              context: context,
              exclude: <String>['KN', 'MF'],
              showPhoneCode: false,
              onSelect: (Country v) {
                country = v;
                widget.onDone(v);
                setState(() {
                  countryName.text = v.name;
                });
              },
              countryListTheme: CountryListThemeData(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                inputDecoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Start typing to search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

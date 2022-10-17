import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter/services.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Please input email";
  }
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return "Invalid Email";
  }
  return null;
}

String? validatePassword(String? value) {
  // TODO: implement validation password
  return null;
}

Future<List<Map<String, dynamic>>> readJson(String jsonFile) async {
  final String response = await rootBundle.loadString('assets/json/$jsonFile');
  var decodedJson = await json.decode(response);
  return (decodedJson as List).map((r) => r as Map<String, dynamic>).toList();
}

Future<Map<String, dynamic>> readObjectJson(String jsonFile) async {
  final String response = await rootBundle.loadString('assets/json/$jsonFile');
  return (await json.decode(response)) as Map<String, dynamic>;
}

String getTimeAgo(String date) {
  return timeago.format(DateTime.parse(date), locale: 'en');
}

bool hasValue(String? value) {
  return value != null && value.isNotEmpty;
}

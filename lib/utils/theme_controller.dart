import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController {
  final isLight = true.obs;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', isLight.value);
  }

  toggle(){
    isLight.toggle();
  }

  Future<void> init() async {
   isLight.value = await _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    });
    Get.changeThemeMode(isLight.value ? ThemeMode.light : ThemeMode.dark);
  }
}

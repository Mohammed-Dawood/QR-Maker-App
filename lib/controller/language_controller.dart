import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  Locale? initialLanguage = GetStorage().read('language') == null
      ? Get.deviceLocale
      : Locale(GetStorage().read('language'));

  bool dropDownButtonLanguage = false;

  String currentLanguage =
      GetStorage().read('language') ?? Get.deviceLocale!.languageCode;

  void toggleDropDownButtonLanguage() {
    dropDownButtonLanguage = !dropDownButtonLanguage;
  }

  Future<void> changeLanguage(String codeLanguage) async {
    Locale locale = Locale(codeLanguage);
    dropDownButtonLanguage = false;
    currentLanguage = codeLanguage;
    GetStorage().write('language', codeLanguage);
    Get.updateLocale(locale);
  }
}

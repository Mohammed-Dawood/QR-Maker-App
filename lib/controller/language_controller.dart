import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  Locale? initialLanguage = GetStorage().read('language') == null
      ? Get.deviceLocale
      : Locale(GetStorage().read('language'));

  String displayLanguage =
      GetStorage().read('language') ?? Get.deviceLocale!.languageCode;

  Future<void> changeLanguage(String codeLanguage) async {
    Locale locale = Locale(codeLanguage);
    displayLanguage = codeLanguage;
    GetStorage().write('language', codeLanguage);
    Get.updateLocale(locale);
  }
}

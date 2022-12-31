import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('ar'),
    const Locale('sv'),
    const Locale('en'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'ar':
        return '🇸🇦';
      case 'sv':
        return '🇸🇪';
      case 'en':
      default:
        return '🇺🇸';
    }
  }
}

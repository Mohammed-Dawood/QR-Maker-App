import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

class VibrationController extends GetxController {
  final box = GetStorage();
  final key = 'vibration';

  bool get initValue => box.read(key) ?? false;

  void switchVibration(value) {
    box.write('vibration', value);
    initValue ? HapticFeedback.vibrate() : null;
    update();
  }

  void vibration() {
    initValue ? HapticFeedback.vibrate() : null;
  }

  changeVibrationState() {
    bool value = initValue;
    value ? null : HapticFeedback.vibrate();
    box.write('vibration', !value);
    update();
  }
}

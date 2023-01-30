import 'package:flutter/material.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';

BoxDecoration backgroundController(ThemeController controller) {
  return BoxDecoration(
      // image: DecorationImage(
      //   image: controller.initValue
      //       ? const AssetImage('images/background_dark.png')
      //       : const AssetImage('images/background_light.png'),
      //   fit: BoxFit.cover,
      // ),
      );
}

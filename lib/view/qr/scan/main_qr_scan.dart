import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/scan/scanning_qr_by_camera.dart';

class MainQrScan extends StatelessWidget {
  const MainQrScan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (ThemeController controller) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: controller.initValue
                ? const AssetImage('images/background_dark.png')
                : const AssetImage('images/background_light.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Get.to(
                    () => const ScanningQRByCamera(),
                  ),
                  icon: const Icon(
                    Icons.qr_code_scanner,
                    size: 30,
                  ),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      'Get Started',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

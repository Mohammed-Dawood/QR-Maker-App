import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/icons_controller.dart';
import 'package:qr_maker_app/controller/labels_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/backround_controller.dart';
import 'package:qr_maker_app/view/qr/scan/scanning_qr_by_camera.dart';

class MainQrScan extends StatelessWidget {
  const MainQrScan({Key? key}) : super(key: key);

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? GetBuilder<ThemeController>(
            init: ThemeController(),
            builder: (ThemeController controller) => Container(
              alignment: Alignment.center,
              decoration: backgroundController(controller),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Padding(
                    padding: (isScreenWidth(context))
                        ? const EdgeInsets.symmetric(horizontal: 100)
                        : const EdgeInsets.symmetric(horizontal: 300),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => Get.to(
                          () => const ScanningQRByCamera(),
                        ),
                        icon: iconController(
                          context,
                          icon: Icons.camera_alt,
                        ),
                        label: labelController(
                          context,
                          label: AppLocalizations.of(context)!.camera,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : GetBuilder<ThemeController>(
            init: ThemeController(),
            builder: (ThemeController controller) => Container(
              alignment: Alignment.center,
              decoration: backgroundController(controller),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 400,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => Get.to(
                          () => const ScanningQRByCamera(),
                        ),
                        icon: iconController(
                          context,
                          icon: Icons.camera_alt,
                        ),
                        label: labelController(
                          context,
                          label: AppLocalizations.of(context)!.camera,
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

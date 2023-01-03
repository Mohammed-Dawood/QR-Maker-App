import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
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
                    padding: (isScreenWidth(context))
                        ? const EdgeInsets.symmetric(horizontal: 100)
                        : const EdgeInsets.symmetric(horizontal: 200),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => Get.to(
                          () => const ScanningQRByCamera(),
                        ),
                        icon: Icon(
                          Icons.camera_alt,
                          size: (isScreenWidth(context)) ? 24 : 30,
                        ),
                        label: Padding(
                          padding: (isScreenWidth(context))
                              ? const EdgeInsets.symmetric(vertical: 18)
                              : const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            AppLocalizations.of(context)!.camera,
                            style: TextStyle(
                              fontSize: (isScreenWidth(context)) ? 18 : 26,
                            ),
                          ),
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
                      horizontal: 300,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => Get.to(
                          () => const ScanningQRByCamera(),
                        ),
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            AppLocalizations.of(context)!.camera,
                            style: const TextStyle(
                              fontSize: 26,
                            ),
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

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/url.dart';
import 'package:qr_maker_app/controller/backround_controller.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/sms.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/wifi.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/date.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/email.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/phone.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/v_card.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/youtube.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/twitter.dart';
import 'package:qr_maker_app/view/qr/maker/link_to_qr_text_field.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/facebook.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/location.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/linkedin.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/instagram.dart';
import 'package:qr_maker_app/view/qr/maker/qr_text_field/whats_upp.dart';

class MainQrMake extends StatelessWidget {
  const MainQrMake({Key? key}) : super(key: key);

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
                body: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (isScreenWidth(context)) ? 3 : 5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    children: [
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeUrl()),
                        assetName: 'images/url.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakePhone()),
                        assetName: 'images/phone.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeSMS()),
                        assetName: 'images/sms.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeYoutube()),
                        assetName: 'images/youtube.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeFacebook()),
                        assetName: 'images/facebook.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeLocation()),
                        assetName: 'images/location.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeWifi()),
                        assetName: 'images/wifi.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeWhatsUpp()),
                        assetName: 'images/whats_upp.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeVCard()),
                        assetName: 'images/v-card.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeInstagram()),
                        assetName: 'images/instagram.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeEmail()),
                        assetName: 'images/email.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeTwitter()),
                        assetName: 'images/twitter.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeDate()),
                        assetName: 'images/date.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeLinkedIn()),
                        assetName: 'images/linkedin.png',
                      ),
                    ],
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
                body: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    children: [
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeUrl()),
                        assetName: 'images/url.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakePhone()),
                        assetName: 'images/phone.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeSMS()),
                        assetName: 'images/sms.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeYoutube()),
                        assetName: 'images/youtube.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeFacebook()),
                        assetName: 'images/facebook.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeLocation()),
                        assetName: 'images/location.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeWifi()),
                        assetName: 'images/wifi.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeWhatsUpp()),
                        assetName: 'images/whats_upp.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeVCard()),
                        assetName: 'images/v-card.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeInstagram()),
                        assetName: 'images/instagram.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeEmail()),
                        assetName: 'images/email.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeTwitter()),
                        assetName: 'images/twitter.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeDate()),
                        assetName: 'images/date.png',
                      ),
                      LinkToTextField(
                        goToLink: () => Get.to(() => const MakeLinkedIn()),
                        assetName: 'images/linkedin.png',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

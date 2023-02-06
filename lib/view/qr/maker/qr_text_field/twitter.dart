import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/icons_controller.dart';
import 'package:qr_maker_app/controller/labels_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/app_bar_controller.dart';
import 'package:qr_maker_app/controller/background_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';

class MakeTwitter extends StatefulWidget {
  const MakeTwitter({Key? key}) : super(key: key);

  @override
  State<MakeTwitter> createState() => _MakeTwitterState();
}

class _MakeTwitterState extends State<MakeTwitter> {
  var valueQr = '';

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController twitterController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    twitterController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? GetBuilder<ThemeController>(
            init: ThemeController(),
            builder: (ThemeController controller) => Container(
              alignment: Alignment.center,
              decoration: backgroundController(controller),
              child: Scaffold(
                appBar: appBarController(
                  context,
                  title: AppLocalizations.of(context)!.twitter,
                ),
                body: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: validateKey,
                      child: Padding(
                        padding: isScreenWidth(context)
                            ? const EdgeInsets.symmetric(horizontal: 40)
                            : const EdgeInsets.symmetric(horizontal: 130),
                        child: Column(
                          children: [
                            Card(
                              child: TextFormField(
                                validator: (value) {
                                  if (!isURL(value)) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_a_valid_link;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: twitterController,
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .twitter_hint_text,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.link,
                                  ),
                                  suffixIcon: twitterController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              twitterController.clear(),
                                          icon: suffixIconController(
                                            context,
                                            icon: Icons.close,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.transparent,
                              shadowColor: Colors.transparent,
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr =
                                              twitterController.text.toString();
                                          Get.to(() =>
                                              StyleShareSaveFavoriteQrCode(
                                                valueQr: valueQr,
                                                image: 'images/twitter.png',
                                                versionValueWithLogo: 6,
                                              ));
                                        },
                                      );
                                    }
                                  },
                                  icon: iconController(
                                    context,
                                    icon: Icons.touch_app,
                                  ),
                                  label: labelCreateQRCodeController(context),
                                ),
                              ),
                            ),
                          ],
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
                appBar: appBarController(
                  context,
                  title: AppLocalizations.of(context)!.twitter,
                ),
                body: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: validateKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 230),
                        child: Column(
                          children: [
                            Card(
                              child: TextFormField(
                                validator: (value) {
                                  if (!isURL(value)) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_a_valid_link;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: twitterController,
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .twitter_hint_text,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.link,
                                  ),
                                  suffixIcon: twitterController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              twitterController.clear(),
                                          icon: suffixIconController(
                                            context,
                                            icon: Icons.close,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.transparent,
                              shadowColor: Colors.transparent,
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr =
                                              twitterController.text.toString();
                                          Get.to(() =>
                                              StyleShareSaveFavoriteQrCode(
                                                valueQr: valueQr,
                                                image: 'images/twitter.png',
                                                versionValueWithLogo: 6,
                                              ));
                                        },
                                      );
                                    }
                                  },
                                  icon: iconController(
                                    context,
                                    icon: Icons.touch_app,
                                  ),
                                  label: labelCreateQRCodeController(context),
                                ),
                              ),
                            ),
                          ],
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

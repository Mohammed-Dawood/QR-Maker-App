import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/icons_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/app_bar_controller.dart';
import 'package:qr_maker_app/controller/background_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class MakeInstagram extends StatefulWidget {
  const MakeInstagram({Key? key}) : super(key: key);

  @override
  State<MakeInstagram> createState() => _MakeInstagramState();
}

class _MakeInstagramState extends State<MakeInstagram> {
  var valueQr = '';

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController instagramController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    instagramController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MediaQuery.of(context).orientation == Orientation.portrait
          ? GetBuilder<ThemeController>(
              init: ThemeController(),
              builder: (ThemeController controller) => Container(
                alignment: Alignment.center,
                decoration: backgroundController(controller),
                child: Scaffold(
                  appBar: appBarController(
                    context,
                    title: AppLocalizations.of(context)!.instagram,
                  ),
                  bottomNavigationBar: FloatingNavbar(
                    borderRadius: 5,
                    itemBorderRadius: 5,
                    currentIndex: 1,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Theme.of(context).primaryColor,
                    iconSize: isScreenWidth(context) ? 24 : 28,
                    fontSize: isScreenWidth(context) ? 12 : 14,
                    backgroundColor: Theme.of(context).primaryColor,
                    selectedBackgroundColor: Theme.of(context).primaryColor,
                    margin: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 10,
                    ),
                    items: [
                      FloatingNavbarItem(
                        icon: Icons.build_rounded,
                        title: AppLocalizations.of(context)!.create_qr_code,
                      ),
                      FloatingNavbarItem(
                        icon: Icons.build_rounded,
                        title: AppLocalizations.of(context)!.create_qr_code,
                      ),
                      FloatingNavbarItem(
                        icon: Icons.build_rounded,
                        title: AppLocalizations.of(context)!.create_qr_code,
                      ),
                    ],
                    onTap: (int screenNumber) {
                      if (validateKey.currentState!.validate()) {
                        setState(
                          () {
                            valueQr = instagramController.text.toString();
                            Get.to(() => StyleShareSaveFavoriteQrCode(
                                  valueQr: valueQr,
                                  image: 'images/instagram.png',
                                  versionValueWithLogo: 6,
                                ));
                          },
                        );
                      }
                    },
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: validateKey,
                        child: Padding(
                          padding: isScreenWidth(context)
                              ? const EdgeInsets.symmetric(horizontal: 30)
                              : const EdgeInsets.symmetric(horizontal: 130),
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
                            controller: instagramController,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.next,
                            cursorColor: Theme.of(context).primaryColor,
                            style: (isScreenWidth(context))
                                ? Theme.of(context).textTheme.titleSmall
                                : Theme.of(context).textTheme.titleMedium,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .instagram_hint_text,
                              prefixIcon: prefixIconController(
                                context,
                                icon: Icons.photo_camera_outlined,
                              ),
                              suffixIcon: instagramController.text.isEmpty
                                  ? Container(
                                      width: 0,
                                    )
                                  : IconButton(
                                      onPressed: () =>
                                          instagramController.clear(),
                                      icon: suffixIconController(
                                        context,
                                        icon: Icons.close,
                                      ),
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
                decoration: backgroundController(controller),
                child: Scaffold(
                  appBar: appBarController(
                    context,
                    title: AppLocalizations.of(context)!.instagram,
                  ),
                  bottomNavigationBar: FloatingNavbar(
                    borderRadius: 5,
                    itemBorderRadius: 5,
                    currentIndex: 1,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Theme.of(context).primaryColor,
                    iconSize: isScreenWidth(context) ? 24 : 28,
                    fontSize: isScreenWidth(context) ? 12 : 14,
                    backgroundColor: Theme.of(context).primaryColor,
                    selectedBackgroundColor: Theme.of(context).primaryColor,
                    margin: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 10,
                    ),
                    items: [
                      FloatingNavbarItem(
                        icon: Icons.build_rounded,
                        title: AppLocalizations.of(context)!.create_qr_code,
                      ),
                      FloatingNavbarItem(
                        icon: Icons.build_rounded,
                        title: AppLocalizations.of(context)!.create_qr_code,
                      ),
                      FloatingNavbarItem(
                        icon: Icons.build_rounded,
                        title: AppLocalizations.of(context)!.create_qr_code,
                      ),
                    ],
                    onTap: (int screenNumber) {
                      if (validateKey.currentState!.validate()) {
                        setState(
                          () {
                            valueQr = instagramController.text.toString();
                            Get.to(() => StyleShareSaveFavoriteQrCode(
                                  valueQr: valueQr,
                                  image: 'images/instagram.png',
                                  versionValueWithLogo: 6,
                                ));
                          },
                        );
                      }
                    },
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: validateKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 230),
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
                            controller: instagramController,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.next,
                            cursorColor: Theme.of(context).primaryColor,
                            style: Theme.of(context).textTheme.titleMedium,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .instagram_hint_text,
                              prefixIcon: prefixIconController(
                                context,
                                icon: Icons.photo_camera_outlined,
                              ),
                              suffixIcon: instagramController.text.isEmpty
                                  ? Container(
                                      width: 0,
                                    )
                                  : IconButton(
                                      onPressed: () =>
                                          instagramController.clear(),
                                      icon: suffixIconController(
                                        context,
                                        icon: Icons.close,
                                      ),
                                    ),
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

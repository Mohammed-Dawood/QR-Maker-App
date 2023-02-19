import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/icons_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/labels_controller.dart';
import 'package:qr_maker_app/controller/app_bar_controller.dart';
import 'package:qr_maker_app/controller/background_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class MakeLinkedIn extends StatefulWidget {
  const MakeLinkedIn({Key? key}) : super(key: key);

  @override
  State<MakeLinkedIn> createState() => _MakeLinkedInState();
}

class _MakeLinkedInState extends State<MakeLinkedIn> {
  var valueQr = '';

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController linkedinController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    linkedinController.addListener(() => setState(() {}));
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
                    title: AppLocalizations.of(context)!.linkedin,
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
                            valueQr = linkedinController.text.toString();
                            Get.to(() => StyleShareSaveFavoriteQrCode(
                                  valueQr: valueQr,
                                  image: 'images/linkedin.png',
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
                            controller: linkedinController,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.next,
                            cursorColor: Theme.of(context).primaryColor,
                            style: (isScreenWidth(context))
                                ? Theme.of(context).textTheme.titleSmall
                                : Theme.of(context).textTheme.titleMedium,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .linkedin_hint_text,
                              prefixIcon: prefixIconController(
                                context,
                                icon: Icons.link,
                              ),
                              suffixIcon: linkedinController.text.isEmpty
                                  ? Container(
                                      width: 0,
                                    )
                                  : IconButton(
                                      onPressed: () =>
                                          linkedinController.clear(),
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
                    title: AppLocalizations.of(context)!.linkedin,
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
                            valueQr = linkedinController.text.toString();
                            Get.to(() => StyleShareSaveFavoriteQrCode(
                                  valueQr: valueQr,
                                  image: 'images/linkedin.png',
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
                            controller: linkedinController,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.next,
                            cursorColor: Theme.of(context).primaryColor,
                            style: Theme.of(context).textTheme.titleMedium,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .linkedin_hint_text,
                              prefixIcon: prefixIconController(
                                context,
                                icon: Icons.link,
                              ),
                              suffixIcon: linkedinController.text.isEmpty
                                  ? Container(
                                      width: 0,
                                    )
                                  : IconButton(
                                      onPressed: () =>
                                          linkedinController.clear(),
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

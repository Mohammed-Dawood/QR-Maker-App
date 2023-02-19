import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/icons_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/app_bar_controller.dart';
import 'package:qr_maker_app/controller/background_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class MakeEmail extends StatefulWidget {
  const MakeEmail({Key? key}) : super(key: key);

  @override
  State<MakeEmail> createState() => _MakeEmailState();
}

class _MakeEmailState extends State<MakeEmail> {
  var valueQr = '';

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    emailController.addListener(() => setState(() {}));
    subjectController.addListener(() => setState(() {}));
    messageController.addListener(() => setState(() {}));
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
                    title: AppLocalizations.of(context)!.email,
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
                            valueQr =
                                'mailto:${emailController.text.toString()}?subject=${subjectController.text.toString()}&body=${messageController.text.toString()}';
                            Get.to(() => StyleShareSaveFavoriteQrCode(
                                  valueQr: valueQr,
                                  image: 'images/email.png',
                                  versionValueWithLogo: QrVersions.auto,
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
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (String? email) {
                                  if (!isEmail(email!)) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_a_valid_emil;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.email,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.email,
                                  ),
                                  suffixIcon: emailController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              emailController.clear(),
                                          icon: suffixIconController(
                                            context,
                                            icon: Icons.close,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                cursorWidth: 3,
                                controller: subjectController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText:
                                      AppLocalizations.of(context)!.subject,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.subject,
                                  ),
                                  suffixIcon: subjectController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              subjectController.clear(),
                                          icon: suffixIconController(
                                            context,
                                            icon: Icons.close,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                minLines: 1,
                                maxLines: 3,
                                cursorWidth: 3,
                                controller: messageController,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                cursorColor: Theme.of(context).primaryColor,
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .message_hint_text,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.message,
                                  ),
                                  suffixIcon: messageController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              messageController.clear(),
                                          icon: suffixIconController(
                                            context,
                                            icon: Icons.close,
                                          ),
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
                    title: AppLocalizations.of(context)!.email,
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
                            valueQr =
                                'mailto:${emailController.text.toString()}?subject=${subjectController.text.toString()}&body=${messageController.text.toString()}';
                            Get.to(() => StyleShareSaveFavoriteQrCode(
                                  valueQr: valueQr,
                                  image: 'images/email.png',
                                  versionValueWithLogo: QrVersions.auto,
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
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (String? email) {
                                  if (!isEmail(email!)) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_a_valid_emil;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.email,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.email,
                                  ),
                                  suffixIcon: emailController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              emailController.clear(),
                                          icon: suffixIconController(
                                            context,
                                            icon: Icons.close,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                cursorWidth: 3,
                                controller: subjectController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText:
                                      AppLocalizations.of(context)!.subject,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.subject,
                                  ),
                                  suffixIcon: subjectController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              subjectController.clear(),
                                          icon: suffixIconController(
                                            context,
                                            icon: Icons.close,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                minLines: 1,
                                maxLines: 3,
                                cursorWidth: 3,
                                controller: messageController,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                cursorColor: Theme.of(context).primaryColor,
                                style: Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .message_hint_text,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.message,
                                  ),
                                  suffixIcon: messageController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              messageController.clear(),
                                          icon: suffixIconController(
                                            context,
                                            icon: Icons.close,
                                          ),
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
            ),
    );
  }
}

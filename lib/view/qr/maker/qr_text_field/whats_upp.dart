import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:qr_maker_app/controller/icons_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/app_bar_controller.dart';
import 'package:qr_maker_app/controller/language_controller.dart';
import 'package:qr_maker_app/controller/background_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class MakeWhatsUpp extends StatefulWidget {
  const MakeWhatsUpp({Key? key}) : super(key: key);

  @override
  State<MakeWhatsUpp> createState() => _MakeWhatsUppState();
}

class _MakeWhatsUppState extends State<MakeWhatsUpp> {
  var valueQr = '';
  var completePhoneNumber = '';

  LanguageController languageController = Get.find();
  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController whatsUppController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    whatsUppController.addListener(() => setState(() {}));
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
                    title: AppLocalizations.of(context)!.whatsapp,
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
                            valueQr = 'https://wa.me/$completePhoneNumber';
                            Get.to(() => StyleShareSaveFavoriteQrCode(
                                  valueQr: valueQr,
                                  image: 'images/whats_upp.png',
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
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: IntlPhoneField(
                              validator: (PhoneNumber? phone) {
                                if (!isLength(phone!.number, 8, 20)) {
                                  return AppLocalizations.of(context)!
                                      .please_enter_a_valid_telephone_number;
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              cursorWidth: 3,
                              controller: whatsUppController,
                              disableLengthCheck: true,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              dropdownIconPosition: IconPosition.leading,
                              showDropdownIcon: false,
                              cursorColor: Theme.of(context).primaryColor,
                              flagsButtonPadding: EdgeInsets.only(
                                left: 10,
                                bottom:
                                    languageController.currentLanguage == "ar"
                                        ? (isScreenWidth(context) ? 6 : 5)
                                        : 2,
                              ),
                              style: (isScreenWidth(context))
                                  ? Theme.of(context).textTheme.titleSmall
                                  : Theme.of(context).textTheme.titleMedium,
                              dropdownTextStyle: (isScreenWidth(context))
                                  ? Theme.of(context).textTheme.titleSmall
                                  : Theme.of(context).textTheme.titleMedium,
                              pickerDialogStyle: PickerDialogStyle(
                                countryCodeStyle: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.displaySmall
                                    : Theme.of(context).textTheme.displayMedium,
                                countryNameStyle: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.displaySmall
                                    : Theme.of(context).textTheme.displayMedium,
                                searchFieldCursorColor:
                                    Theme.of(context).primaryColor,
                                searchFieldInputDecoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .search_country,
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        (isScreenWidth(context) ? 16 : 22),
                                  ),
                                  isCollapsed: false,
                                  isDense: true,
                                  suffixIcon: suffixIconController(
                                    context,
                                    icon: Icons.search,
                                  ),
                                ),
                                width: isScreenWidth(context)
                                    ? double.infinity
                                    : 500,
                              ),
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .telephone_number,
                                suffixIcon: whatsUppController.text.isEmpty
                                    ? Container(
                                        width: 0,
                                      )
                                    : IconButton(
                                        onPressed: () =>
                                            whatsUppController.clear(),
                                        icon: suffixIconController(
                                          context,
                                          icon: Icons.close,
                                        ),
                                      ),
                              ),
                              onChanged: (PhoneNumber phone) {
                                completePhoneNumber = phone.completeNumber;
                              },
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
                    title: AppLocalizations.of(context)!.whatsapp,
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
                            valueQr = 'https://wa.me/$completePhoneNumber';
                            Get.to(() => StyleShareSaveFavoriteQrCode(
                                  valueQr: valueQr,
                                  image: 'images/whats_upp.png',
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
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: IntlPhoneField(
                              validator: (PhoneNumber? phone) {
                                if (!isLength(phone!.number, 8, 20)) {
                                  return AppLocalizations.of(context)!
                                      .please_enter_a_valid_telephone_number;
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              cursorWidth: 3,
                              controller: whatsUppController,
                              disableLengthCheck: true,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              dropdownIconPosition: IconPosition.leading,
                              showDropdownIcon: false,
                              cursorColor: Theme.of(context).primaryColor,
                              flagsButtonPadding: EdgeInsets.only(
                                left: 10,
                                bottom:
                                    languageController.currentLanguage == "ar"
                                        ? 5
                                        : 2,
                              ),
                              style: Theme.of(context).textTheme.titleMedium,
                              dropdownTextStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              pickerDialogStyle: PickerDialogStyle(
                                countryCodeStyle:
                                    Theme.of(context).textTheme.displayMedium,
                                countryNameStyle:
                                    Theme.of(context).textTheme.displayMedium,
                                searchFieldCursorColor:
                                    Theme.of(context).primaryColor,
                                searchFieldInputDecoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .search_country,
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                  isCollapsed: false,
                                  isDense: true,
                                  suffixIcon: suffixIconController(
                                    context,
                                    icon: Icons.search,
                                  ),
                                ),
                                width: 500,
                              ),
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .telephone_number,
                                suffixIcon: whatsUppController.text.isEmpty
                                    ? Container(
                                        width: 0,
                                      )
                                    : IconButton(
                                        onPressed: () =>
                                            whatsUppController.clear(),
                                        icon: suffixIconController(
                                          context,
                                          icon: Icons.close,
                                        ),
                                      ),
                              ),
                              onChanged: (PhoneNumber phone) {
                                completePhoneNumber = phone.completeNumber;
                              },
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

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/language_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';

class MakeSMS extends StatefulWidget {
  const MakeSMS({Key? key}) : super(key: key);

  @override
  State<MakeSMS> createState() => _MakeSMSState();
}

class _MakeSMSState extends State<MakeSMS> {
  var valueQr = '';
  var completePhoneNumber = '';
  LanguageController languageController = Get.find();
  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    phoneController.addListener(() => setState(() {}));
    messageController.addListener(() => setState(() {}));

    super.initState();
  }

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
                appBar: AppBar(
                  title: Text(
                    AppLocalizations.of(context)!.message_app_bar,
                    style:
                        TextStyle(fontSize: (isScreenWidth(context)) ? 20 : 28),
                  ),
                  iconTheme: IconThemeData(
                    size: (isScreenWidth(context)) ? 24 : 30,
                    color: Colors.white,
                  ),
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
                                  controller: phoneController,
                                  disableLengthCheck: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  dropdownIconPosition: IconPosition.leading,
                                  showDropdownIcon: false,
                                  cursorColor: Theme.of(context).primaryColor,
                                  flagsButtonPadding: EdgeInsets.only(
                                    left: 10,
                                    bottom:
                                        languageController.currentLanguage ==
                                                "ar"
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
                                        ? Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                    countryNameStyle: (isScreenWidth(context))
                                        ? Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                    searchFieldCursorColor:
                                        Theme.of(context).primaryColor,
                                    searchFieldInputDecoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!
                                          .search_country,
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            (isScreenWidth(context) ? 18 : 26),
                                      ),
                                      isCollapsed: false,
                                      isDense: true,
                                      suffixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                        size:
                                            (isScreenWidth(context)) ? 24 : 30,
                                      ),
                                    ),
                                    width: isScreenWidth(context)
                                        ? double.infinity
                                        : 500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .telephone_number,
                                    suffixIcon: phoneController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                phoneController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
                                            ),
                                          ),
                                  ),
                                  onChanged: (PhoneNumber phone) {
                                    completePhoneNumber = phone.completeNumber;
                                  },
                                ),
                              ),
                            ),
                            Card(
                              child: TextFormField(
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
                                  prefixIcon: Icon(
                                    Icons.message,
                                    color: Theme.of(context).primaryColor,
                                    size: (isScreenWidth(context)) ? 24 : 30,
                                  ),
                                  suffixIcon: messageController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              messageController.clear(),
                                          icon: Icon(
                                            Icons.close,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: (isScreenWidth(context))
                                                ? 24
                                                : 30,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Card(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr =
                                              'SMSTO:$completePhoneNumber: ${messageController.text.toString()}';
                                          Get.to(() =>
                                              StyleShareSaveFavoriteQrCode(
                                                valueQr: valueQr,
                                                image: 'images/sms.png',
                                                versionValueWithLogo: 6,
                                              ));
                                        },
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.touch_app,
                                    size: (isScreenWidth(context)) ? 24 : 30,
                                  ),
                                  label: Padding(
                                    padding: (isScreenWidth(context))
                                        ? const EdgeInsets.symmetric(
                                            vertical: 18)
                                        : const EdgeInsets.symmetric(
                                            vertical: 20),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .create_qr_code,
                                      style: TextStyle(
                                          fontSize: (isScreenWidth(context))
                                              ? 18
                                              : 26),
                                    ),
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
                appBar: AppBar(
                  title: Text(
                    AppLocalizations.of(context)!.message_app_bar,
                    style: const TextStyle(fontSize: 28),
                  ),
                  iconTheme: const IconThemeData(
                    size: 30,
                    color: Colors.white,
                  ),
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
                                  controller: phoneController,
                                  disableLengthCheck: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  dropdownIconPosition: IconPosition.leading,
                                  showDropdownIcon: false,
                                  cursorColor: Theme.of(context).primaryColor,
                                  flagsButtonPadding: EdgeInsets.only(
                                    left: 10,
                                    bottom:
                                        languageController.currentLanguage ==
                                                "ar"
                                            ? 5
                                            : 2,
                                  ),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  dropdownTextStyle:
                                      Theme.of(context).textTheme.titleMedium,
                                  pickerDialogStyle: PickerDialogStyle(
                                    countryCodeStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    countryNameStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    searchFieldCursorColor:
                                        Theme.of(context).primaryColor,
                                    searchFieldInputDecoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!
                                          .search_country,
                                      hintStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                      ),
                                      isCollapsed: false,
                                      isDense: true,
                                      suffixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    width: 500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .telephone_number,
                                    suffixIcon: phoneController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                phoneController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
                                            ),
                                          ),
                                  ),
                                  onChanged: (PhoneNumber phone) {
                                    completePhoneNumber = phone.completeNumber;
                                  },
                                ),
                              ),
                            ),
                            Card(
                              child: TextFormField(
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
                                  prefixIcon: Icon(
                                    Icons.message,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                  suffixIcon: messageController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              messageController.clear(),
                                          icon: Icon(
                                            Icons.close,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 30,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Card(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr =
                                              'SMSTO:$completePhoneNumber: ${messageController.text.toString()}';
                                          Get.to(() =>
                                              StyleShareSaveFavoriteQrCode(
                                                valueQr: valueQr,
                                                image: 'images/sms.png',
                                                versionValueWithLogo: 6,
                                              ));
                                        },
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.touch_app,
                                    size: 30,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .create_qr_code,
                                      style: const TextStyle(
                                        fontSize: 26,
                                      ),
                                    ),
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
          );
  }
}

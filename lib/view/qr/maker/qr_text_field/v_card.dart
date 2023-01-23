import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:validators/validators.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:qr_maker_app/controller/icons_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/app_bar_controller.dart';
import 'package:qr_maker_app/controller/language_controller.dart';
import 'package:qr_maker_app/controller/labels_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';

class MakeVCard extends StatefulWidget {
  const MakeVCard({Key? key}) : super(key: key);

  @override
  State<MakeVCard> createState() => _MakeVCardState();
}

class _MakeVCardState extends State<MakeVCard> {
  var valueQr = '';
  var completePhoneNumberFax = '';
  var completePhoneNumberWork = '';
  var completePhoneNumberHome = '';
  var completePhoneNumberMobil = '';

  LanguageController languageController = Get.find();
  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController urlController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bDayController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    urlController.addListener(() => setState(() {}));
    zipController.addListener(() => setState(() {}));
    faxController.addListener(() => setState(() {}));
    cityController.addListener(() => setState(() {}));
    nameController.addListener(() => setState(() {}));
    workController.addListener(() => setState(() {}));
    homeController.addListener(() => setState(() {}));
    stateController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    mobileController.addListener(() => setState(() {}));
    streetController.addListener(() => setState(() {}));
    countryController.addListener(() => setState(() {}));

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
                appBar: appBarController(
                  context,
                  title: AppLocalizations.of(context)!.v_card,
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Form(
                        key: validateKey,
                        child: Padding(
                          padding: isScreenWidth(context)
                              ? const EdgeInsets.symmetric(horizontal: 40)
                              : const EdgeInsets.symmetric(horizontal: 130),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 150,
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (String? name) {
                                    if (isNull(name)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_your_Name;
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.full_name,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.person,
                                    ),
                                    suffixIcon: nameController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                nameController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.email,
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
                              ),
                              Card(
                                child: Directionality(
                                  textDirection: ui.TextDirection.ltr,
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
                                    controller: mobileController,
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
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                    dropdownTextStyle: (isScreenWidth(context))
                                        ? Theme.of(context).textTheme.titleSmall
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium,
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
                                      searchFieldInputDecoration:
                                          InputDecoration(
                                        hintText: AppLocalizations.of(context)!
                                            .search_country,
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: (isScreenWidth(context)
                                              ? 16
                                              : 22),
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
                                      hintText:
                                          AppLocalizations.of(context)!.mobile,
                                      suffixIcon: mobileController.text.isEmpty
                                          ? Container(
                                              width: 0,
                                            )
                                          : IconButton(
                                              onPressed: () =>
                                                  mobileController.clear(),
                                              icon: suffixIconController(
                                                context,
                                                icon: Icons.close,
                                              ),
                                            ),
                                    ),
                                    onChanged: (PhoneNumber phone) {
                                      completePhoneNumberMobil =
                                          phone.completeNumber;
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                child: Directionality(
                                  textDirection: ui.TextDirection.ltr,
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
                                    controller: workController,
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
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                    dropdownTextStyle: (isScreenWidth(context))
                                        ? Theme.of(context).textTheme.titleSmall
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium,
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
                                      searchFieldInputDecoration:
                                          InputDecoration(
                                        hintText: AppLocalizations.of(context)!
                                            .search_country,
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: (isScreenWidth(context)
                                              ? 16
                                              : 22),
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
                                      hintText:
                                          AppLocalizations.of(context)!.work,
                                      suffixIcon: workController.text.isEmpty
                                          ? Container(
                                              width: 0,
                                            )
                                          : IconButton(
                                              onPressed: () =>
                                                  workController.clear(),
                                              icon: suffixIconController(
                                                context,
                                                icon: Icons.close,
                                              ),
                                            ),
                                    ),
                                    onChanged: (PhoneNumber phone) {
                                      completePhoneNumberWork =
                                          phone.completeNumber;
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                child: Directionality(
                                  textDirection: ui.TextDirection.ltr,
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
                                    controller: homeController,
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
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                    dropdownTextStyle: (isScreenWidth(context))
                                        ? Theme.of(context).textTheme.titleSmall
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium,
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
                                      searchFieldInputDecoration:
                                          InputDecoration(
                                        hintText: AppLocalizations.of(context)!
                                            .search_country,
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: (isScreenWidth(context)
                                              ? 16
                                              : 22),
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
                                      hintText:
                                          AppLocalizations.of(context)!.home,
                                      suffixIcon: homeController.text.isEmpty
                                          ? Container(
                                              width: 0,
                                            )
                                          : IconButton(
                                              onPressed: () =>
                                                  homeController.clear(),
                                              icon: suffixIconController(
                                                context,
                                                icon: Icons.close,
                                              ),
                                            ),
                                    ),
                                    onChanged: (PhoneNumber phone) {
                                      completePhoneNumberHome =
                                          phone.completeNumber;
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                child: Directionality(
                                  textDirection: ui.TextDirection.ltr,
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
                                    controller: faxController,
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
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                    dropdownTextStyle: (isScreenWidth(context))
                                        ? Theme.of(context).textTheme.titleSmall
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium,
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
                                      searchFieldInputDecoration:
                                          InputDecoration(
                                        hintText: AppLocalizations.of(context)!
                                            .search_country,
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: (isScreenWidth(context)
                                              ? 16
                                              : 22),
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
                                      hintText:
                                          AppLocalizations.of(context)!.fax,
                                      suffixIcon: faxController.text.isEmpty
                                          ? Container(
                                              width: 0,
                                            )
                                          : IconButton(
                                              onPressed: () =>
                                                  faxController.clear(),
                                              icon: suffixIconController(
                                                context,
                                                icon: Icons.close,
                                              ),
                                            ),
                                    ),
                                    onChanged: (PhoneNumber phone) {
                                      completePhoneNumberFax =
                                          phone.completeNumber;
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: bDayController,
                                  keyboardType: TextInputType.datetime,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                      initialDatePickerMode:
                                          DatePickerMode.year,
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                    );
                                    if (newDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyyMMdd')
                                              .format(newDate);
                                      setState(
                                        () {
                                          bDayController.text =
                                              formattedDate; //set output date to TextField value.
                                        },
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .date_of_birth,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.date_range,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: urlController,
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .url_hint_text,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.link,
                                    ),
                                    suffixIcon: urlController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                urlController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: streetController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .street_address,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.location_on,
                                    ),
                                    suffixIcon: streetController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                streetController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: zipController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.zip_code,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.location_on,
                                    ),
                                    suffixIcon: zipController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                zipController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: cityController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.city,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.location_on,
                                    ),
                                    suffixIcon: cityController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                cityController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: stateController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.state,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.location_on,
                                    ),
                                    suffixIcon: stateController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                stateController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: countryController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.country,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.location_on,
                                    ),
                                    suffixIcon: countryController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                countryController.clear(),
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
                                      if (validateKey.currentState!
                                          .validate()) {
                                        setState(
                                          () {
                                            valueQr = [
                                              "BEGIN:VCARD",
                                              "VERSION:3.0",
                                              "FN: ${nameController.text.toString()}",
                                              "EMAIL: ${emailController.text.toString()}",
                                              "TEL;TYPE=CELL: $completePhoneNumberMobil",
                                              "TEL;TYPE=WORK: $completePhoneNumberWork",
                                              "TEL;TYPE=Home: $completePhoneNumberHome",
                                              "TEL;TYPE=FAX: $completePhoneNumberFax",
                                              "URL:${urlController.text.toString()}",
                                              "BDAY:${bDayController.text.toString()}",
                                              "ADR;TYPE=home:;;${streetController.text.toString()} ;${cityController.text.toString()};${stateController.text.toString()};${zipController.text.toString()};${countryController.text.toString()} ",
                                              "END:VCARD",
                                            ].join("\r\n");
                                            Get.to(() =>
                                                StyleShareSaveFavoriteQrCode(
                                                  valueQr: valueQr,
                                                  image: 'images/v-card.png',
                                                  versionValueWithLogo:
                                                      QrVersions.auto,
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
                              const SizedBox(
                                height: 150,
                              ),
                            ],
                          ),
                        ),
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
                appBar: appBarController(
                  context,
                  title: AppLocalizations.of(context)!.v_card,
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Form(
                        key: validateKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 230),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (String? name) {
                                    if (isNull(name)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_your_Name;
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.full_name,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.person,
                                    ),
                                    suffixIcon: nameController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                nameController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.email,
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
                              ),
                              Card(
                                child: Directionality(
                                  textDirection: ui.TextDirection.ltr,
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
                                    controller: mobileController,
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
                                      searchFieldInputDecoration:
                                          InputDecoration(
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
                                      hintText:
                                          AppLocalizations.of(context)!.mobile,
                                      suffixIcon: mobileController.text.isEmpty
                                          ? Container(
                                              width: 0,
                                            )
                                          : IconButton(
                                              onPressed: () =>
                                                  mobileController.clear(),
                                              icon: suffixIconController(
                                                context,
                                                icon: Icons.close,
                                              ),
                                            ),
                                    ),
                                    onChanged: (PhoneNumber phone) {
                                      completePhoneNumberMobil =
                                          phone.completeNumber;
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                child: Directionality(
                                  textDirection: ui.TextDirection.ltr,
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
                                    controller: workController,
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
                                      searchFieldInputDecoration:
                                          InputDecoration(
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
                                      hintText:
                                          AppLocalizations.of(context)!.work,
                                      suffixIcon: workController.text.isEmpty
                                          ? Container(
                                              width: 0,
                                            )
                                          : IconButton(
                                              onPressed: () =>
                                                  workController.clear(),
                                              icon: suffixIconController(
                                                context,
                                                icon: Icons.close,
                                              ),
                                            ),
                                    ),
                                    onChanged: (PhoneNumber phone) {
                                      completePhoneNumberWork =
                                          phone.completeNumber;
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                child: Directionality(
                                  textDirection: ui.TextDirection.ltr,
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
                                    controller: homeController,
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
                                      searchFieldInputDecoration:
                                          InputDecoration(
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
                                      hintText:
                                          AppLocalizations.of(context)!.home,
                                      suffixIcon: homeController.text.isEmpty
                                          ? Container(
                                              width: 0,
                                            )
                                          : IconButton(
                                              onPressed: () =>
                                                  homeController.clear(),
                                              icon: suffixIconController(
                                                context,
                                                icon: Icons.close,
                                              ),
                                            ),
                                    ),
                                    onChanged: (PhoneNumber phone) {
                                      completePhoneNumberHome =
                                          phone.completeNumber;
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                child: Directionality(
                                  textDirection: ui.TextDirection.ltr,
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
                                    controller: faxController,
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
                                      searchFieldInputDecoration:
                                          InputDecoration(
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
                                      hintText:
                                          AppLocalizations.of(context)!.fax,
                                      suffixIcon: faxController.text.isEmpty
                                          ? Container(
                                              width: 0,
                                            )
                                          : IconButton(
                                              onPressed: () =>
                                                  faxController.clear(),
                                              icon: suffixIconController(
                                                context,
                                                icon: Icons.close,
                                              ),
                                            ),
                                    ),
                                    onChanged: (PhoneNumber phone) {
                                      completePhoneNumberFax =
                                          phone.completeNumber;
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: bDayController,
                                  keyboardType: TextInputType.datetime,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                      initialDatePickerMode:
                                          DatePickerMode.year,
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                    );
                                    if (newDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyyMMdd')
                                              .format(newDate);
                                      setState(
                                        () {
                                          bDayController.text =
                                              formattedDate; //set output date to TextField value.
                                        },
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .date_of_birth,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.date_range,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: urlController,
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .url_hint_text,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.link,
                                    ),
                                    suffixIcon: urlController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                urlController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: streetController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .street_address,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.location_on,
                                    ),
                                    suffixIcon: streetController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                streetController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: zipController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.zip_code,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.location_on,
                                    ),
                                    suffixIcon: zipController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                zipController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: cityController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.city,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.location_on,
                                    ),
                                    suffixIcon: cityController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                cityController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: stateController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.state,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.location_on,
                                    ),
                                    suffixIcon: stateController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                stateController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  cursorWidth: 3,
                                  controller: countryController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context)!.country,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.location_on,
                                    ),
                                    suffixIcon: countryController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                countryController.clear(),
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
                                      if (validateKey.currentState!
                                          .validate()) {
                                        setState(
                                          () {
                                            valueQr = [
                                              "BEGIN:VCARD",
                                              "VERSION:3.0",
                                              "FN: ${nameController.text.toString()}",
                                              "EMAIL: ${emailController.text.toString()}",
                                              "TEL;TYPE=CELL: $completePhoneNumberMobil",
                                              "TEL;TYPE=WORK: $completePhoneNumberWork",
                                              "TEL;TYPE=Home: $completePhoneNumberHome",
                                              "TEL;TYPE=FAX: $completePhoneNumberFax",
                                              "URL:${urlController.text.toString()}",
                                              "BDAY:${bDayController.text.toString()}",
                                              "ADR;TYPE=home:;;${streetController.text.toString()} ;${cityController.text.toString()};${stateController.text.toString()};${zipController.text.toString()};${countryController.text.toString()} ",
                                              "END:VCARD",
                                            ].join("\r\n");
                                            Get.to(() =>
                                                StyleShareSaveFavoriteQrCode(
                                                  valueQr: valueQr,
                                                  image: 'images/v-card.png',
                                                  versionValueWithLogo:
                                                      QrVersions.auto,
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
                              const SizedBox(
                                height: 150,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

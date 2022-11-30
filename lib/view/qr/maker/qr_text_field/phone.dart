import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';

class MakePhone extends StatefulWidget {
  const MakePhone({Key? key}) : super(key: key);

  @override
  State<MakePhone> createState() => _MakePhoneState();
}

class _MakePhoneState extends State<MakePhone> {
  var valueQr = '';
  var completePhoneNumber = '';

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    phoneController.addListener(() => setState(() {}));
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
                    'Phone QR Code',
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
                              child: IntlPhoneField(
                                validator: (PhoneNumber? phone) {
                                  if (!isLength(phone!.number, 8, 20)) {
                                    return 'Please enter a valid Phone Number';
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
                                dropdownIconPosition: IconPosition.trailing,
                                cursorColor: Theme.of(context).primaryColor,
                                flagsButtonPadding: const EdgeInsets.only(
                                  left: 10,
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
                                      : Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                  countryNameStyle: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.displaySmall
                                      : Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                  searchFieldCursorColor:
                                      Theme.of(context).primaryColor,
                                  searchFieldInputDecoration: InputDecoration(
                                    hintText: 'Search Country',
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
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                  ),
                                  width: isScreenWidth(context)
                                      ? double.infinity
                                      : 500,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  suffixIcon: phoneController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              phoneController.clear(),
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
                                onChanged: (PhoneNumber phone) {
                                  completePhoneNumber = phone.completeNumber;
                                },
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
                                          valueQr = completePhoneNumber;
                                          Get.to(() =>
                                              StyleShareSaveFavoriteQrCode(
                                                valueQr: valueQr,
                                                image: 'images/phone.png',
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
                                      'Create QR Code',
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
                  title: const Text(
                    'Phone QR Code',
                    style: TextStyle(fontSize: 28),
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
                              child: IntlPhoneField(
                                validator: (PhoneNumber? phone) {
                                  if (!isLength(phone!.number, 8, 20)) {
                                    return 'Please enter a valid Phone Number';
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
                                dropdownIconPosition: IconPosition.trailing,
                                cursorColor: Theme.of(context).primaryColor,
                                flagsButtonPadding: const EdgeInsets.only(
                                  left: 10,
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
                                    hintText: 'Search Country',
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
                                  hintText: 'Phone Number',
                                  suffixIcon: phoneController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              phoneController.clear(),
                                          icon: Icon(
                                            Icons.close,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 30,
                                          ),
                                        ),
                                ),
                                onChanged: (PhoneNumber phone) {
                                  completePhoneNumber = phone.completeNumber;
                                },
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
                                          valueQr = completePhoneNumber;
                                          Get.to(() =>
                                              StyleShareSaveFavoriteQrCode(
                                                valueQr: valueQr,
                                                image: 'images/phone.png',
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
                                  label: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Text(
                                      'Create QR Code',
                                      style: TextStyle(
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

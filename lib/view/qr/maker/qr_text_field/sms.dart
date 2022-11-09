import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';

class MakeSMS extends StatefulWidget {
  const MakeSMS({Key? key}) : super(key: key);

  @override
  State<MakeSMS> createState() => _MakeSMSState();
}

class _MakeSMSState extends State<MakeSMS> {
  var valueQr = '';
  var completePhoneNumber = '';

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
                    'SMS QR Code',
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
                                flagsButtonPadding:
                                    const EdgeInsets.only(left: 10),
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                                dropdownTextStyle: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                                pickerDialogStyle: PickerDialogStyle(
                                  width: isScreenWidth(context)
                                      ? double.infinity
                                      : 500,
                                  searchFieldCursorColor: Colors.white,
                                  searchFieldInputDecoration: InputDecoration(
                                    filled: true,
                                    fillColor: Theme.of(context).primaryColor,
                                    suffixIcon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    label: const Text('Search country'),
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    floatingLabelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  filled: true,
                                  fillColor: Colors.white,
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
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                onChanged: (PhoneNumber phone) {
                                  completePhoneNumber = phone.completeNumber;
                                },
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
                                  hintText: 'Message',
                                  filled: true,
                                  fillColor: Colors.white,
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
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
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
                    'SMS QR Code',
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
                                flagsButtonPadding:
                                    const EdgeInsets.only(left: 10),
                                style: Theme.of(context).textTheme.titleMedium,
                                dropdownTextStyle:
                                    Theme.of(context).textTheme.titleMedium,
                                pickerDialogStyle: PickerDialogStyle(
                                  width: 500,
                                  searchFieldCursorColor: Colors.white,
                                  searchFieldInputDecoration: InputDecoration(
                                    filled: true,
                                    fillColor: Theme.of(context).primaryColor,
                                    suffixIcon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    label: const Text('Search country'),
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    floatingLabelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  filled: true,
                                  fillColor: Colors.white,
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
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                onChanged: (PhoneNumber phone) {
                                  completePhoneNumber = phone.completeNumber;
                                },
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
                                  hintText: 'Message',
                                  filled: true,
                                  fillColor: Colors.white,
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
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
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

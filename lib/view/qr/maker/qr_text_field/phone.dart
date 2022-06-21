import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/maker/qr_style_and_share.dart';

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
              padding: const EdgeInsets.all(30),
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
                body: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: validateKey,
                      child: Padding(
                        padding: isScreenWidth(context)
                            ? const EdgeInsets.symmetric(horizontal: 10)
                            : const EdgeInsets.symmetric(horizontal: 100),
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
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                dropdownTextStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                pickerDialogStyle: PickerDialogStyle(
                                  backgroundColor: Colors.white,
                                  countryCodeStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  countryNameStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  searchFieldCursorColor: Colors.white,
                                  searchFieldInputDecoration: InputDecoration(
                                    filled: true,
                                    fillColor: Theme.of(context).primaryColor,
                                    label: const Text('Search country'),
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 30,
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
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr = completePhoneNumber;
                                          Get.to(() => QrStyleAndShare(
                                              valueQr: valueQr));
                                        },
                                      );
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    child: Text('Create QR Code'),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  label: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    child: Text('Back'),
                                  ),
                                  icon: const Icon(Icons.arrow_back_ios_new),
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
              padding: const EdgeInsets.all(30),
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
                body: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: validateKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 200),
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
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                dropdownTextStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                pickerDialogStyle: PickerDialogStyle(
                                  backgroundColor: Colors.white,
                                  countryCodeStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  countryNameStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  searchFieldCursorColor: Colors.white,
                                  searchFieldInputDecoration: InputDecoration(
                                    filled: true,
                                    fillColor: Theme.of(context).primaryColor,
                                    label: const Text('Search country'),
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 30,
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
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr = completePhoneNumber;
                                          Get.to(() => QrStyleAndShare(
                                              valueQr: valueQr));
                                        },
                                      );
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    child: Text('Create QR Code'),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  label: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    child: Text('Back'),
                                  ),
                                  icon: const Icon(Icons.arrow_back_ios_new),
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

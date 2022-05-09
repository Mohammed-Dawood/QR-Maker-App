import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/maker/qr_style_and_share.dart';

class MakeWifi extends StatefulWidget {
  const MakeWifi({Key? key}) : super(key: key);

  @override
  State<MakeWifi> createState() => _MakeWifiState();
}

class _MakeWifiState extends State<MakeWifi> {
  var valueQr = '';
  String dropValue = 'WPA/WPA2';

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();

  TextEditingController nameNetController = TextEditingController();
  TextEditingController passNetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
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
                child: Column(
                  children: [
                    Card(
                      child: TextFormField(
                        validator: (value) {
                          if (isNull(value)) {
                            return 'Please enter a Wifi Name';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorWidth: 3,
                        controller: nameNetController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: Theme.of(context).primaryColor,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Wifi Name',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.wifi,
                            color: Theme.of(context).primaryColor,
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
                      child: TextFormField(
                        validator: (value) {
                          if (isNull(value)) {
                            return 'Please enter a Wifi Password';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorWidth: 3,
                        controller: passNetController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Theme.of(context).primaryColor,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Wifi Password',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.wifi_password,
                            color: Theme.of(context).primaryColor,
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
                      shape: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black54,
                        ),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.security,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: DropdownButton<String>(
                                hint: const Text(
                                  ' Select Wifi Security Type',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(5),
                                iconSize: 36,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                underline: Container(
                                  height: 0,
                                ),
                                value: dropValue,
                                onChanged: (newValue) {
                                  setState(
                                    () {
                                      dropValue = newValue!;
                                    },
                                  );
                                },
                                items: <String>['WPA/WPA2', 'WEP']
                                    .map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
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
                                  valueQr = 'WIFI:S:' +
                                      nameNetController.text.toString() +
                                      ';T:' +
                                      dropValue +
                                      ';P:' +
                                      passNetController.text.toString() +
                                      ';H:False;;';
                                  Get.to(
                                      () => QrStyleAndShare(valueQr: valueQr));
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
    );
  }
}

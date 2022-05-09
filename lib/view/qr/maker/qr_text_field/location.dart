import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/maker/qr_style_and_share.dart';

class MakeLocation extends StatefulWidget {
  const MakeLocation({Key? key}) : super(key: key);

  @override
  State<MakeLocation> createState() => _MakeLocationState();
}

class _MakeLocationState extends State<MakeLocation> {
  var valueQr = '';
  GlobalKey<FormState> validateKey = GlobalKey<FormState>();

  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

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
                          if (isNull(value!)) {
                            return 'Please enter a valid latitude';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorWidth: 3,
                        controller: latitudeController,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        textInputAction: TextInputAction.next,
                        cursorColor: Theme.of(context).primaryColor,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter latitude',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.location_on,
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
                          if (isNull(value!)) {
                            return 'Please enter a valid longitude';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorWidth: 3,
                        controller: longitudeController,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        textInputAction: TextInputAction.next,
                        cursorColor: Theme.of(context).primaryColor,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter longitude',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.location_on,
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
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (validateKey.currentState!.validate()) {
                              setState(
                                () {
                                  valueQr = 'geo:' +
                                      latitudeController.text +
                                      ',' +
                                      longitudeController.text;
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
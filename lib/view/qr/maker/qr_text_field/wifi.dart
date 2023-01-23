import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/icons_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/app_bar_controller.dart';
import 'package:qr_maker_app/controller/labels_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';

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

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    nameNetController.addListener(() => setState(() {}));
    passNetController.addListener(() => setState(() {}));
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
                  title: AppLocalizations.of(context)!.wifi,
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
                              child: TextFormField(
                                validator: (value) {
                                  if (isNull(value)) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_a_wifi_name;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: nameNetController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText:
                                      AppLocalizations.of(context)!.wifi_name,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.wifi,
                                  ),
                                  suffixIcon: nameNetController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              nameNetController.clear(),
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
                                validator: (value) {
                                  if (isNull(value)) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_a_wifi_password;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: passNetController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor: Theme.of(context).primaryColor,
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .wifi_password,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.wifi_password,
                                  ),
                                  suffixIcon: passNetController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              passNetController.clear(),
                                          icon: suffixIconController(
                                            context,
                                            icon: Icons.close,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Card(
                              shape: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                              color: Theme.of(context).primaryColor,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: isScreenWidth(context) ? 10 : 20,
                                  right: isScreenWidth(context) ? 10 : 20,
                                ),
                                child: DropdownButton<String>(
                                  items: <String>['WPA/WPA2', 'WEP']
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: (isScreenWidth(context))
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  value: dropValue,
                                  onChanged: (newValue) {
                                    setState(
                                      () {
                                        dropValue = newValue!;
                                      },
                                    );
                                  },
                                  underline: Container(
                                    height: 0,
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  iconSize: 36,
                                  isExpanded: true,
                                  itemHeight: isScreenWidth(context) ? 60 : 70,
                                  dropdownColor: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(5),
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
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr = 'WIFI:S:' +
                                              nameNetController.text
                                                  .toString() +
                                              ';T:' +
                                              dropValue +
                                              ';P:' +
                                              passNetController.text
                                                  .toString() +
                                              ';H:False;;';
                                          Get.to(() =>
                                              StyleShareSaveFavoriteQrCode(
                                                valueQr: valueQr,
                                                image: 'images/wifi.png',
                                                versionValueWithLogo: 6,
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
                appBar: appBarController(
                  context,
                  title: AppLocalizations.of(context)!.wifi,
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
                              child: TextFormField(
                                validator: (value) {
                                  if (isNull(value)) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_a_wifi_name;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: nameNetController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText:
                                      AppLocalizations.of(context)!.wifi_name,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.wifi,
                                  ),
                                  suffixIcon: nameNetController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              nameNetController.clear(),
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
                                validator: (value) {
                                  if (isNull(value)) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_a_wifi_password;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: passNetController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor: Theme.of(context).primaryColor,
                                style: Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .wifi_password,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.wifi_password,
                                  ),
                                  suffixIcon: passNetController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              passNetController.clear(),
                                          icon: suffixIconController(
                                            context,
                                            icon: Icons.close,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Card(
                              shape: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                              color: Theme.of(context).primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: DropdownButton<String>(
                                  items: <String>['WPA/WPA2', 'WEP']
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  value: dropValue,
                                  onChanged: (newValue) {
                                    setState(
                                      () {
                                        dropValue = newValue!;
                                      },
                                    );
                                  },
                                  underline: Container(
                                    height: 0,
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  iconSize: 36,
                                  isExpanded: true,
                                  itemHeight: 70,
                                  dropdownColor: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(5),
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
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr = 'WIFI:S:' +
                                              nameNetController.text
                                                  .toString() +
                                              ';T:' +
                                              dropValue +
                                              ';P:' +
                                              passNetController.text
                                                  .toString() +
                                              ';H:False;;';
                                          Get.to(() =>
                                              StyleShareSaveFavoriteQrCode(
                                                valueQr: valueQr,
                                                image: 'images/wifi.png',
                                                versionValueWithLogo: 6,
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

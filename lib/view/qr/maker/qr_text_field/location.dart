import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/icons_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/app_bar_controller.dart';
import 'package:qr_maker_app/controller/labels_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';

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

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    latitudeController.addListener(() => setState(() {}));
    longitudeController.addListener(() => setState(() {}));
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
                  title: AppLocalizations.of(context)!.location,
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
                                  if (isNull(value!)) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_a_valid_latitude;
                                    ;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: latitudeController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  signed: true,
                                  decimal: true,
                                ),
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .enter_latitude,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.location_on,
                                  ),
                                  suffixIcon: latitudeController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              latitudeController.clear(),
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
                                  if (isNull(value!)) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_a_valid_longitude;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: longitudeController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  signed: true,
                                  decimal: true,
                                ),
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .enter_longitude,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.location_on,
                                  ),
                                  suffixIcon: longitudeController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              longitudeController.clear(),
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
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr = 'geo:' +
                                              latitudeController.text +
                                              ',' +
                                              longitudeController.text;
                                          Get.to(() =>
                                              StyleShareSaveFavoriteQrCode(
                                                valueQr: valueQr,
                                                image: 'images/location.png',
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
                  title: AppLocalizations.of(context)!.location,
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
                                  if (isNull(value!)) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_a_valid_latitude;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: latitudeController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  signed: true,
                                  decimal: true,
                                ),
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .enter_latitude,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.location_on,
                                  ),
                                  suffixIcon: latitudeController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              latitudeController.clear(),
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
                                  if (isNull(value!)) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_a_valid_longitude;
                                    ;
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: longitudeController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  signed: true,
                                  decimal: true,
                                ),
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .enter_longitude,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.location_on,
                                  ),
                                  suffixIcon: longitudeController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              longitudeController.clear(),
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
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr = 'geo:' +
                                              latitudeController.text +
                                              ',' +
                                              longitudeController.text;
                                          Get.to(() =>
                                              StyleShareSaveFavoriteQrCode(
                                                valueQr: valueQr,
                                                image: 'images/location.png',
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

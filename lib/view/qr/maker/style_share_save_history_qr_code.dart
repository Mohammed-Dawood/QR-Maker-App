import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/vibration_controller.dart';
import 'package:qr_maker_app/controller/save_qr_code_controller.dart';
import 'package:qr_maker_app/controller/share_qr_code_controller.dart';
import 'package:qr_maker_app/controller/history_qr_code_controller.dart';

class StyleShareSaveHistoryQrCode extends StatefulWidget {
  const StyleShareSaveHistoryQrCode({
    Key? key,
    required this.valueQr,
  }) : super(key: key);

  final String valueQr;

  @override
  State<StyleShareSaveHistoryQrCode> createState() =>
      _StyleShareSaveHistoryQrCodeState();
}

class _StyleShareSaveHistoryQrCodeState
    extends State<StyleShareSaveHistoryQrCode> {
  // double versionValue = QrVersions.auto;
  bool gapSwitch = false;
  bool eyesSwitch = false;
  bool dataSwitch = false;
  Color eyesColor = Colors.black;
  Color dataColor = Colors.black;
  Color backgroundColor = Colors.white;

  ScreenshotController screenshotController = ScreenshotController();

  HistoryQrCodeController historyQrCodeController = Get.find();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

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
                    'QR Style',
                    style:
                        TextStyle(fontSize: (isScreenWidth(context)) ? 20 : 28),
                  ),
                  iconTheme: IconThemeData(
                    size: (isScreenWidth(context)) ? 24 : 30,
                    color: Colors.white,
                  ),
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: isScreenWidth(context) ? 20 : 60,
                        ),
                        child: Center(
                          child: Card(
                            color: backgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Screenshot(
                                controller: screenshotController,
                                child: QrImage(
                                  size: (isScreenWidth(context)) ? 200 : 300,
                                  gapless: gapSwitch,
                                  data: widget.valueQr,
                                  version: QrVersions.auto,
                                  semanticsLabel: 'qr maker',
                                  backgroundColor: backgroundColor,
                                  eyeStyle: QrEyeStyle(
                                    eyeShape: eyesSwitch
                                        ? QrEyeShape.circle
                                        : QrEyeShape.square,
                                    color: eyesColor,
                                  ),
                                  dataModuleStyle: QrDataModuleStyle(
                                    dataModuleShape: dataSwitch
                                        ? QrDataModuleShape.circle
                                        : QrDataModuleShape.square,
                                    color: dataColor,
                                  ),
                                  // embeddedImage: const AssetImage('images/url.png'),
                                  // embeddedImageStyle: QrEmbeddedImageStyle(
                                  //   size: const Size(50, 50),
                                  // ),
                                  errorStateBuilder: (cxt, err) {
                                    return const Center(
                                      child: Text(
                                        "Uh oh! Something went wrong...",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: (isScreenWidth(context)) ? 50 : 100,
                          left: (isScreenWidth(context)) ? 40 : 150,
                          right: (isScreenWidth(context)) ? 40 : 150,
                        ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Gap',
                                      style: (isScreenWidth(context))
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline3
                                          : Theme.of(context)
                                              .textTheme
                                              .headline2,
                                    ),
                                    Switch(
                                      value: gapSwitch,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            gapSwitch = value;
                                          },
                                        );
                                      },
                                      activeColor: Colors.white,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Eyes',
                                      style: (isScreenWidth(context))
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline3
                                          : Theme.of(context)
                                              .textTheme
                                              .headline2,
                                    ),
                                    Switch(
                                      value: eyesSwitch,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            eyesSwitch = value;
                                          },
                                        );
                                      },
                                      activeColor: Colors.white,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Data',
                                      style: (isScreenWidth(context))
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline3
                                          : Theme.of(context)
                                              .textTheme
                                              .headline2,
                                    ),
                                    Switch(
                                      value: dataSwitch,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            dataSwitch = value;
                                          },
                                        );
                                      },
                                      activeColor: Colors.white,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Eyes Color',
                                      style: (isScreenWidth(context))
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline3
                                          : Theme.of(context)
                                              .textTheme
                                              .headline2,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            content: SingleChildScrollView(
                                              child: ColorPicker(
                                                hexInputBar: true,
                                                labelTypes: const [],
                                                pickerColor: eyesColor,
                                                colorPickerWidth:
                                                    isScreenWidth(context)
                                                        ? 220
                                                        : 400,
                                                pickerAreaBorderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                paletteType: PaletteType.hsl,
                                                pickerAreaHeightPercent: 1.0,
                                                onColorChanged: (Color color) =>
                                                    setState(
                                                  () {
                                                    eyesColor = color;
                                                  },
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Select'),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.color_lens,
                                        size:
                                            (isScreenWidth(context)) ? 30 : 35,
                                        color: eyesColor,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Data Color',
                                      style: (isScreenWidth(context))
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline3
                                          : Theme.of(context)
                                              .textTheme
                                              .headline2,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            content: SingleChildScrollView(
                                              child: ColorPicker(
                                                hexInputBar: true,
                                                labelTypes: const [],
                                                pickerColor: dataColor,
                                                colorPickerWidth:
                                                    isScreenWidth(context)
                                                        ? 220
                                                        : 400,
                                                pickerAreaBorderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                paletteType: PaletteType.hsl,
                                                pickerAreaHeightPercent: 1.0,
                                                onColorChanged: (Color color) =>
                                                    setState(
                                                  () {
                                                    dataColor = color;
                                                  },
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Select'),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.color_lens,
                                        size:
                                            (isScreenWidth(context)) ? 30 : 35,
                                        color: dataColor,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Background',
                                      style: (isScreenWidth(context))
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline3
                                          : Theme.of(context)
                                              .textTheme
                                              .headline2,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            content: SingleChildScrollView(
                                              child: ColorPicker(
                                                hexInputBar: true,
                                                labelTypes: const [],
                                                pickerColor: backgroundColor,
                                                colorPickerWidth:
                                                    isScreenWidth(context)
                                                        ? 220
                                                        : 400,
                                                pickerAreaBorderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                paletteType: PaletteType.hsl,
                                                pickerAreaHeightPercent: 1.0,
                                                onColorChanged: (Color color) =>
                                                    setState(
                                                  () {
                                                    backgroundColor = color;
                                                  },
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Select'),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.color_lens,
                                        size:
                                            (isScreenWidth(context)) ? 30 : 35,
                                        color: backgroundColor,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: (isScreenWidth(context)) ? 40 : 150,
                          right: (isScreenWidth(context)) ? 40 : 150,
                        ),
                        child: GetBuilder<SaveQrCodeController>(
                          init: SaveQrCodeController(),
                          builder:
                              (SaveQrCodeController saveQrCodeController) =>
                                  GetBuilder<VibrationController>(
                            init: VibrationController(),
                            builder:
                                (VibrationController vibrationController) =>
                                    Card(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final image =
                                        await screenshotController.capture();
                                    saveQrCodeController.saveQrCode(image!);
                                    vibrationController.vibration();
                                  },
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    child: Text(
                                      'Save QR Code',
                                      style: (isScreenWidth(context))
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline3
                                          : Theme.of(context)
                                              .textTheme
                                              .headline2,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.save,
                                    size: (isScreenWidth(context)) ? 30 : 35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: (isScreenWidth(context)) ? 40 : 150,
                          right: (isScreenWidth(context)) ? 40 : 150,
                        ),
                        child: GetBuilder<ShareQrCodeController>(
                          init: ShareQrCodeController(),
                          builder: (ShareQrCodeController controller) =>
                              GetBuilder<VibrationController>(
                            init: VibrationController(),
                            builder:
                                (VibrationController vibrationController) =>
                                    Card(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final image =
                                        await screenshotController.capture();
                                    controller.shareQrCode(image!);
                                    vibrationController.vibration();
                                  },
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    child: Text(
                                      'Share QR Code',
                                      style: (isScreenWidth(context))
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline3
                                          : Theme.of(context)
                                              .textTheme
                                              .headline2,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.share,
                                    size: (isScreenWidth(context)) ? 30 : 35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: (isScreenWidth(context)) ? 40 : 150,
                          right: (isScreenWidth(context)) ? 40 : 150,
                        ),
                        child: GetBuilder<VibrationController>(
                          init: VibrationController(),
                          builder: (VibrationController vibrationController) =>
                              Card(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final image =
                                      await screenshotController.capture();
                                  historyQrCodeController
                                      .addQrCodeImageToHistory(image!);
                                  vibrationController.vibration();
                                },
                                label: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  child: Text(
                                    'Add To History',
                                    style: (isScreenWidth(context))
                                        ? Theme.of(context).textTheme.headline3
                                        : Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.history,
                                  size: (isScreenWidth(context)) ? 30 : 35,
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
                    'QR Style',
                    style: TextStyle(fontSize: 28),
                  ),
                  iconTheme: const IconThemeData(
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Center(
                          child: Card(
                            color: backgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Screenshot(
                                controller: screenshotController,
                                child: QrImage(
                                  size: 300,
                                  gapless: gapSwitch,
                                  data: widget.valueQr,
                                  version: QrVersions.auto,
                                  semanticsLabel: 'qr maker',
                                  backgroundColor: backgroundColor,
                                  eyeStyle: QrEyeStyle(
                                    eyeShape: eyesSwitch
                                        ? QrEyeShape.circle
                                        : QrEyeShape.square,
                                    color: eyesColor,
                                  ),
                                  dataModuleStyle: QrDataModuleStyle(
                                    dataModuleShape: dataSwitch
                                        ? QrDataModuleShape.circle
                                        : QrDataModuleShape.square,
                                    color: dataColor,
                                  ),
                                  // embeddedImage: const AssetImage('images/url.png'),
                                  // embeddedImageStyle: QrEmbeddedImageStyle(
                                  //   size: const Size(50, 50),
                                  // ),
                                  errorStateBuilder: (cxt, err) {
                                    return const Center(
                                      child: Text(
                                        "Uh oh! Something went wrong...",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 250,
                          right: 250,
                        ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Gap',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    Switch(
                                      value: gapSwitch,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            gapSwitch = value;
                                          },
                                        );
                                      },
                                      activeColor: Colors.white,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Eyes',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    Switch(
                                      value: eyesSwitch,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            eyesSwitch = value;
                                          },
                                        );
                                      },
                                      activeColor: Colors.white,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Data',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    Switch(
                                      value: dataSwitch,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            dataSwitch = value;
                                          },
                                        );
                                      },
                                      activeColor: Colors.white,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Eyes Color',
                                      style: (isScreenWidth(context))
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline3
                                          : Theme.of(context)
                                              .textTheme
                                              .headline2,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            content: SingleChildScrollView(
                                              child: ColorPicker(
                                                hexInputBar: true,
                                                labelTypes: const [],
                                                pickerColor: eyesColor,
                                                colorPickerWidth: 400,
                                                pickerAreaBorderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                paletteType: PaletteType.hsl,
                                                pickerAreaHeightPercent: 1.0,
                                                onColorChanged: (Color color) =>
                                                    setState(
                                                  () {
                                                    eyesColor = color;
                                                  },
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Select'),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.color_lens,
                                        size: 35,
                                        color: eyesColor,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Data Color',
                                      style: (isScreenWidth(context))
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline3
                                          : Theme.of(context)
                                              .textTheme
                                              .headline2,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            content: SingleChildScrollView(
                                              child: ColorPicker(
                                                hexInputBar: true,
                                                labelTypes: const [],
                                                pickerColor: dataColor,
                                                colorPickerWidth: 400,
                                                pickerAreaBorderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                paletteType: PaletteType.hsl,
                                                pickerAreaHeightPercent: 1.0,
                                                onColorChanged: (Color color) =>
                                                    setState(
                                                  () {
                                                    dataColor = color;
                                                  },
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Select'),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.color_lens,
                                        size: 35,
                                        color: dataColor,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Background',
                                      style: (isScreenWidth(context))
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline3
                                          : Theme.of(context)
                                              .textTheme
                                              .headline2,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            content: SingleChildScrollView(
                                              child: ColorPicker(
                                                hexInputBar: true,
                                                labelTypes: const [],
                                                pickerColor: backgroundColor,
                                                colorPickerWidth: 400,
                                                pickerAreaBorderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                paletteType: PaletteType.hsl,
                                                pickerAreaHeightPercent: 1.0,
                                                onColorChanged: (Color color) =>
                                                    setState(
                                                  () {
                                                    backgroundColor = color;
                                                  },
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Select'),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.color_lens,
                                        size: 35,
                                        color: backgroundColor,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 250,
                          right: 250,
                        ),
                        child: GetBuilder<SaveQrCodeController>(
                          init: SaveQrCodeController(),
                          builder: (SaveQrCodeController controller) =>
                              GetBuilder<VibrationController>(
                            init: VibrationController(),
                            builder:
                                (VibrationController vibrationController) =>
                                    Card(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final image =
                                        await screenshotController.capture();
                                    controller.saveQrCode(image!);
                                    vibrationController.vibration();
                                  },
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    child: Text(
                                      'Save QR Code',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.save,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 250,
                          right: 250,
                        ),
                        child: GetBuilder<ShareQrCodeController>(
                          init: ShareQrCodeController(),
                          builder: (ShareQrCodeController controller) =>
                              GetBuilder<VibrationController>(
                            init: VibrationController(),
                            builder:
                                (VibrationController vibrationController) =>
                                    Card(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final image =
                                        await screenshotController.capture();
                                    controller.shareQrCode(image!);
                                    vibrationController.vibration();
                                  },
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    child: Text(
                                      'Share QR Code',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.share,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 250,
                          right: 250,
                        ),
                        child: GetBuilder<VibrationController>(
                          init: VibrationController(),
                          builder: (VibrationController vibrationController) =>
                              Card(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final image =
                                      await screenshotController.capture();
                                  historyQrCodeController
                                      .addQrCodeImageToHistory(image!);
                                },
                                label: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  child: Text(
                                    'Add To History',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.history,
                                  size: 35,
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
          );
  }
}

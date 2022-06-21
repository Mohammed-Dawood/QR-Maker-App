import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/qr_share_and_save_controller.dart';

class QrStyleAndShare extends StatefulWidget {
  const QrStyleAndShare({
    Key? key,
    required this.valueQr,
  }) : super(key: key);

  final String valueQr;

  @override
  State<QrStyleAndShare> createState() => _QrStyleAndShareState();
}

class _QrStyleAndShareState extends State<QrStyleAndShare> {
  // double versionValue = QrVersions.auto;
  bool gapSwitch = false;
  bool eyesSwitch = false;
  bool dataSwitch = false;
  Color eyesColor = Colors.black;
  Color dataColor = Colors.black;
  Color backgroundColor = Colors.white;

  ScreenshotController screenshotController = ScreenshotController();

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
                  actions: [
                    GetBuilder<QrShareAndSaveController>(
                      init: QrShareAndSaveController(),
                      builder: (QrShareAndSaveController controller) =>
                          IconButton(
                        onPressed: () async {
                          final image = await screenshotController.capture();
                          controller.saveAndShare(image!);
                        },
                        icon: const Icon(
                          Icons.share,
                        ),
                      ),
                    ),
                  ],
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
                                        Get.bottomSheet(
                                          SizedBox(
                                            height: 550,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    FloatingActionButton.small(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: const Icon(
                                                        Icons.cancel_outlined,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ColorPicker(
                                                  pickerColor: eyesColor,
                                                  paletteType:
                                                      PaletteType.hueWheel,
                                                  colorPickerWidth: 300,
                                                  labelTypes: const [],
                                                  hexInputBar: true,
                                                  onColorChanged: (color) =>
                                                      setState(
                                                    () {
                                                      eyesColor = color;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          isScrollControlled: true,
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
                                        Get.bottomSheet(
                                          SizedBox(
                                            height: 550,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    FloatingActionButton.small(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: const Icon(
                                                        Icons.cancel_outlined,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ColorPicker(
                                                  pickerColor: dataColor,
                                                  paletteType:
                                                      PaletteType.hueWheel,
                                                  colorPickerWidth: 300,
                                                  labelTypes: const [],
                                                  hexInputBar: true,
                                                  onColorChanged: (color) =>
                                                      setState(
                                                    () {
                                                      dataColor = color;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          isScrollControlled: true,
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
                                        Get.bottomSheet(
                                          SizedBox(
                                            height: 550,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    FloatingActionButton.small(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: const Icon(
                                                        Icons.cancel_outlined,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ColorPicker(
                                                  pickerColor: backgroundColor,
                                                  paletteType:
                                                      PaletteType.hueWheel,
                                                  colorPickerWidth: 300,
                                                  labelTypes: const [],
                                                  hexInputBar: true,
                                                  onColorChanged: (color) =>
                                                      setState(
                                                    () {
                                                      backgroundColor = color;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          isScrollControlled: true,
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
                  actions: [
                    GetBuilder<QrShareAndSaveController>(
                      init: QrShareAndSaveController(),
                      builder: (QrShareAndSaveController controller) =>
                          IconButton(
                        onPressed: () async {
                          final image = await screenshotController.capture();
                          controller.saveAndShare(image!);
                        },
                        icon: const Icon(
                          Icons.share,
                        ),
                      ),
                    ),
                  ],
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
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.bottomSheet(
                                          SizedBox(
                                            height: 550,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    FloatingActionButton.small(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: const Icon(
                                                        Icons.cancel_outlined,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ColorPicker(
                                                  pickerColor: eyesColor,
                                                  paletteType:
                                                      PaletteType.hueWheel,
                                                  colorPickerWidth: 300,
                                                  labelTypes: const [],
                                                  hexInputBar: true,
                                                  onColorChanged: (color) =>
                                                      setState(
                                                    () {
                                                      eyesColor = color;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          isScrollControlled: true,
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
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.bottomSheet(
                                          SizedBox(
                                            height: 550,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    FloatingActionButton.small(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: const Icon(
                                                        Icons.cancel_outlined,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ColorPicker(
                                                  pickerColor: dataColor,
                                                  paletteType:
                                                      PaletteType.hueWheel,
                                                  colorPickerWidth: 300,
                                                  labelTypes: const [],
                                                  hexInputBar: true,
                                                  onColorChanged: (color) =>
                                                      setState(
                                                    () {
                                                      dataColor = color;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          isScrollControlled: true,
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
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.bottomSheet(
                                          SizedBox(
                                            height: 550,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    FloatingActionButton.small(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: const Icon(
                                                        Icons.cancel_outlined,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ColorPicker(
                                                  pickerColor: backgroundColor,
                                                  paletteType:
                                                      PaletteType.hueWheel,
                                                  colorPickerWidth: 300,
                                                  labelTypes: const [],
                                                  hexInputBar: true,
                                                  onColorChanged: (color) =>
                                                      setState(
                                                    () {
                                                      backgroundColor = color;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          isScrollControlled: true,
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
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

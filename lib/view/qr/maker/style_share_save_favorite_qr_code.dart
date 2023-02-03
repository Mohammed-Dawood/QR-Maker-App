import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:qr_maker_app/controller/icons_controller.dart';
import 'package:qr_maker_app/controller/labels_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/app_bar_controller.dart';
import 'package:qr_maker_app/controller/backround_controller.dart';
import 'package:qr_maker_app/controller/vibration_controller.dart';
import 'package:qr_maker_app/controller/save_qr_code_controller.dart';
import 'package:qr_maker_app/controller/share_qr_code_controller.dart';
import 'package:qr_maker_app/controller/animation_drop_down_controller.dart';
import 'package:qr_maker_app/controller/favorite/make_qr_code_list_controller.dart';

class StyleShareSaveFavoriteQrCode extends StatefulWidget {
  const StyleShareSaveFavoriteQrCode({
    Key? key,
    required this.valueQr,
    required this.image,
    required this.versionValueWithLogo,
  }) : super(key: key);

  final String valueQr;
  final String image;
  final int versionValueWithLogo;

  @override
  State<StyleShareSaveFavoriteQrCode> createState() =>
      _StyleShareSaveFavoriteQrCodeState();
}

class _StyleShareSaveFavoriteQrCodeState
    extends State<StyleShareSaveFavoriteQrCode> {
  String? logo;
  double logoSize = 40;
  bool gapSwitch = false;
  bool logoSwitch = false;
  bool editQrCode = false;
  bool eyesSwitch = false;
  bool dataSwitch = false;
  bool logoPadding = true;
  Color eyesColor = Colors.black;
  Color dataColor = Colors.black;
  int versionValue = QrVersions.auto;
  Color backgroundColor = Colors.white;

  ScreenshotController screenshotController = ScreenshotController();

  MakeQrCodeListController makeQrCodeListController = Get.find();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? GetBuilder<ThemeController>(
            init: ThemeController(),
            builder: (ThemeController controller) => Container(
              alignment: Alignment.center,
              decoration: backgroundController(controller),
              child: Scaffold(
                appBar: appBarController(
                  context,
                  title: AppLocalizations.of(context)!.edit_qr_style,
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        // top: isScreenWidth(context) ? 20 : 60,
                        bottom: isScreenWidth(context) ? 20 : 60,
                      ),
                      child: Center(
                        child: Card(
                          color: backgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Screenshot(
                              controller: screenshotController,
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  QrImage(
                                    size: (isScreenWidth(context)) ? 240 : 400,
                                    gapless: gapSwitch,
                                    data: widget.valueQr,
                                    version: logoSwitch
                                        ? widget.versionValueWithLogo
                                        : versionValue,
                                    semanticsLabel: 'qr maker',
                                    backgroundColor: backgroundColor,
                                    constrainErrorBounds: true,
                                    // embeddedImageEmitsError: false,
                                    errorCorrectionLevel: QrErrorCorrectLevel.L,
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
                                    // embeddedImage: logoSwitch
                                    //     ? AssetImage(widget.image)
                                    //     : null,
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
                                  Container(
                                    color: logoSwitch
                                        ? backgroundColor
                                        : Colors.transparent,
                                    width: logoPadding
                                        ? logoSize +
                                            (isScreenWidth(context) ? 5 : 10)
                                        : 0,
                                    height: logoPadding
                                        ? logoSize +
                                            (isScreenWidth(context) ? 5 : 10)
                                        : 0,
                                  ),
                                  Image.asset(
                                    logo ?? widget.image,
                                    width: logoSwitch ? logoSize : 0,
                                    height: logoSwitch ? logoSize : 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: isScreenWidth(context) ? 300 : 600,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              color: Colors.transparent,
                              shadowColor: Colors.transparent,
                              child: SizedBox(
                                width: isScreenWidth(context) ? 250 : 410,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      logoSwitch = false;
                                      editQrCode = !editQrCode;
                                    });
                                  },
                                  icon: iconController(
                                    context,
                                    icon: Icons.edit,
                                  ),
                                  label: labelController(
                                    context,
                                    label: AppLocalizations.of(context)!
                                        .edit_qr_code,
                                  ),
                                ),
                              ),
                            ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 100,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: isScreenWidth(context) ? 250 : 410,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: isScreenWidth(context) ? 3 : 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.gap,
                                          style: (isScreenWidth(context))
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
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
                                          inactiveTrackColor:
                                              Colors.grey.shade900,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 200,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: isScreenWidth(context) ? 250 : 410,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: isScreenWidth(context) ? 3 : 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.eyes,
                                          style: (isScreenWidth(context))
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
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
                                          inactiveTrackColor:
                                              Colors.grey.shade900,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 300,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: isScreenWidth(context) ? 250 : 410,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: isScreenWidth(context) ? 3 : 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.data,
                                          style: (isScreenWidth(context))
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
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
                                          inactiveTrackColor:
                                              Colors.grey.shade900,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 400,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: isScreenWidth(context) ? 250 : 410,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: isScreenWidth(context) ? 3 : 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.logo,
                                          style: (isScreenWidth(context))
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                        ),
                                        Switch(
                                          value: logoSwitch,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                logoSwitch = value;
                                              },
                                            );
                                          },
                                          activeColor: Colors.white,
                                          inactiveTrackColor:
                                              Colors.grey.shade900,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            editQrCode
                                ? AnimationDropDownController(
                                    changeState: logoSwitch,
                                    durationTime: 100,
                                    firstChildeCard: Card(
                                      child: SizedBox(
                                        width:
                                            isScreenWidth(context) ? 250 : 410,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical:
                                                isScreenWidth(context) ? 3 : 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .library,
                                                style: (isScreenWidth(context))
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .displaySmall
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  try {
                                                    final image =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    if (image == null) return;
                                                    setState(() {
                                                      logo = image.path;
                                                    });
                                                  } on PlatformException catch (e) {
                                                    print(
                                                        'Failed to pick image: $e');
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.add_photo_alternate,
                                                  size: (isScreenWidth(context))
                                                      ? 24
                                                      : 30,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 0,
                                  ),
                            editQrCode
                                ? AnimationDropDownController(
                                    changeState: logoSwitch,
                                    durationTime: 200,
                                    firstChildeCard: Card(
                                      child: SizedBox(
                                        width:
                                            isScreenWidth(context) ? 250 : 410,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical:
                                                isScreenWidth(context) ? 3 : 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .camera,
                                                style: (isScreenWidth(context))
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .displaySmall
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  try {
                                                    final image =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                    if (image == null) return;
                                                    setState(() {
                                                      logo = image.path;
                                                    });
                                                  } on PlatformException catch (e) {
                                                    print(
                                                        'Failed to pick image: $e');
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.add_a_photo,
                                                  size: (isScreenWidth(context))
                                                      ? 24
                                                      : 30,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 0,
                                  ),
                            editQrCode
                                ? AnimationDropDownController(
                                    changeState: logoSwitch,
                                    durationTime: 300,
                                    firstChildeCard: Card(
                                      child: SizedBox(
                                        width:
                                            isScreenWidth(context) ? 250 : 410,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical:
                                                isScreenWidth(context) ? 3 : 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .padding,
                                                style: (isScreenWidth(context))
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .displaySmall
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                              ),
                                              Switch(
                                                value: logoPadding,
                                                onChanged: (value) {
                                                  setState(
                                                    () {
                                                      logoPadding = value;
                                                    },
                                                  );
                                                },
                                                activeColor: Colors.white,
                                                inactiveTrackColor:
                                                    Colors.grey.shade900,
                                                inactiveThumbColor:
                                                    Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 0,
                                  ),
                            editQrCode
                                ? AnimationDropDownController(
                                    changeState: logoSwitch,
                                    durationTime: 400,
                                    firstChildeCard: Card(
                                      child: SizedBox(
                                        width:
                                            isScreenWidth(context) ? 250 : 410,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical:
                                                isScreenWidth(context) ? 3 : 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .logo_size,
                                                style: (isScreenWidth(context))
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .displaySmall
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                              ),
                                              SizedBox(
                                                width: isScreenWidth(context)
                                                    ? 120
                                                    : 200,
                                                child: Slider(
                                                  min: 20.0,
                                                  max: isScreenWidth(context)
                                                      ? 45.0
                                                      : 70.0,
                                                  value: logoSize,
                                                  onChanged: ((value) {
                                                    setState(
                                                      () {
                                                        logoSize = value;
                                                      },
                                                    );
                                                  }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 0,
                                  ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 500,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: isScreenWidth(context) ? 250 : 410,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: isScreenWidth(context) ? 3 : 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .eyes_color,
                                          style: (isScreenWidth(context))
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                content: SingleChildScrollView(
                                                  child: ColorPicker(
                                                    hexInputBar: false,
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
                                                    paletteType:
                                                        PaletteType.hsl,
                                                    pickerAreaHeightPercent:
                                                        1.0,
                                                    onColorChanged:
                                                        (Color color) =>
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
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .ok,
                                                      style: (isScreenWidth(
                                                              context))
                                                          ? Theme.of(context)
                                                              .textTheme
                                                              .displaySmall
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .displayMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.color_lens,
                                            size: (isScreenWidth(context))
                                                ? 24
                                                : 30,
                                            color: eyesColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 600,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: isScreenWidth(context) ? 250 : 410,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: isScreenWidth(context) ? 3 : 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .data_color,
                                          style: (isScreenWidth(context))
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                content: SingleChildScrollView(
                                                  child: ColorPicker(
                                                    hexInputBar: false,
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
                                                    paletteType:
                                                        PaletteType.hsl,
                                                    pickerAreaHeightPercent:
                                                        1.0,
                                                    onColorChanged:
                                                        (Color color) =>
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
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .ok,
                                                      style: (isScreenWidth(
                                                              context))
                                                          ? Theme.of(context)
                                                              .textTheme
                                                              .displaySmall
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .displayMedium,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.color_lens,
                                            size: (isScreenWidth(context))
                                                ? 24
                                                : 30,
                                            color: dataColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 700,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: isScreenWidth(context) ? 250 : 410,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: isScreenWidth(context) ? 3 : 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .bg_color,
                                          style: (isScreenWidth(context))
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                content: SingleChildScrollView(
                                                  child: ColorPicker(
                                                    hexInputBar: false,
                                                    labelTypes: const [],
                                                    pickerColor:
                                                        backgroundColor,
                                                    colorPickerWidth:
                                                        isScreenWidth(context)
                                                            ? 220
                                                            : 400,
                                                    pickerAreaBorderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                    paletteType:
                                                        PaletteType.hsl,
                                                    pickerAreaHeightPercent:
                                                        1.0,
                                                    onColorChanged:
                                                        (Color color) =>
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
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .ok,
                                                      style: (isScreenWidth(
                                                              context))
                                                          ? Theme.of(context)
                                                              .textTheme
                                                              .displaySmall
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .displayMedium,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.color_lens,
                                            size: (isScreenWidth(context))
                                                ? 24
                                                : 30,
                                            color: backgroundColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<SaveQrCodeController>(
                              init: SaveQrCodeController(),
                              builder:
                                  (SaveQrCodeController saveQrCodeController) =>
                                      GetBuilder<VibrationController>(
                                init: VibrationController(),
                                builder:
                                    (VibrationController vibrationController) =>
                                        Card(
                                  color: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  child: SizedBox(
                                    width: isScreenWidth(context) ? 250 : 410,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        final image = await screenshotController
                                            .capture();
                                        saveQrCodeController.saveQrCode(
                                            image!, context);
                                        vibrationController.vibration();
                                      },
                                      icon: iconController(
                                        context,
                                        icon: Icons.save,
                                      ),
                                      label: labelController(
                                        context,
                                        label: AppLocalizations.of(context)!
                                            .save_qr_code,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<ShareQrCodeController>(
                              init: ShareQrCodeController(),
                              builder: (ShareQrCodeController controller) =>
                                  GetBuilder<VibrationController>(
                                init: VibrationController(),
                                builder:
                                    (VibrationController vibrationController) =>
                                        Card(
                                  color: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  child: SizedBox(
                                    width: isScreenWidth(context) ? 250 : 410,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        final image = await screenshotController
                                            .capture();
                                        controller.shareQrCode(image!);
                                        vibrationController.vibration();
                                      },
                                      icon: iconController(
                                        context,
                                        icon: Icons.share,
                                      ),
                                      label: labelController(
                                        context,
                                        label: AppLocalizations.of(context)!
                                            .share_qr_code,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<VibrationController>(
                              init: VibrationController(),
                              builder:
                                  (VibrationController vibrationController) =>
                                      Card(
                                color: Colors.transparent,
                                shadowColor: Colors.transparent,
                                child: SizedBox(
                                  width: isScreenWidth(context) ? 250 : 410,
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      final image =
                                          await screenshotController.capture();
                                      makeQrCodeListController
                                          .addItemToMakeQrCodeList(
                                        image!,
                                        context,
                                      );
                                      vibrationController.vibration();
                                    },
                                    icon: iconController(context,
                                        icon: Icons.favorite),
                                    label: labelController(
                                      context,
                                      label: AppLocalizations.of(context)!
                                          .add_to_favorite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : GetBuilder<ThemeController>(
            init: ThemeController(),
            builder: (ThemeController controller) => Container(
              alignment: Alignment.center,
              decoration: backgroundController(controller),
              child: Scaffold(
                appBar: appBarController(
                  context,
                  title: AppLocalizations.of(context)!.edit_qr_style,
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        // top: 60,
                        bottom: 20,
                      ),
                      child: Center(
                        child: Card(
                          color: backgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Screenshot(
                              controller: screenshotController,
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  QrImage(
                                    size: 400,
                                    gapless: gapSwitch,
                                    data: widget.valueQr,
                                    version: logoSwitch
                                        ? widget.versionValueWithLogo
                                        : versionValue,
                                    semanticsLabel: 'qr maker',
                                    backgroundColor: backgroundColor,
                                    constrainErrorBounds: true,
                                    // embeddedImageEmitsError: false,
                                    errorCorrectionLevel: QrErrorCorrectLevel.L,
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
                                    // embeddedImage: logoSwitch
                                    //     ? AssetImage(widget.image)
                                    //     : null,
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
                                  Container(
                                    color: logoSwitch
                                        ? backgroundColor
                                        : Colors.transparent,
                                    width: logoPadding ? logoSize + 10 : 0,
                                    height: logoPadding ? logoSize + 10 : 0,
                                  ),
                                  Image.asset(
                                    logo ?? widget.image,
                                    width: logoSwitch ? logoSize : 0,
                                    height: logoSwitch ? logoSize : 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 350,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              color: Colors.transparent,
                              shadowColor: Colors.transparent,
                              child: SizedBox(
                                width: 410,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      logoSwitch = false;
                                      editQrCode = !editQrCode;
                                    });
                                  },
                                  icon: iconController(
                                    context,
                                    icon: Icons.edit,
                                  ),
                                  label: labelController(
                                    context,
                                    label: AppLocalizations.of(context)!
                                        .edit_qr_code,
                                  ),
                                ),
                              ),
                            ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 100,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: 410,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.gap,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
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
                                          inactiveTrackColor:
                                              Colors.grey.shade900,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 200,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: 410,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.eyes,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
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
                                          inactiveTrackColor:
                                              Colors.grey.shade900,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 300,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: 410,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.data,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
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
                                          inactiveTrackColor:
                                              Colors.grey.shade900,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 400,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: 410,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.logo,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        Switch(
                                          value: logoSwitch,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                logoSwitch = value;
                                              },
                                            );
                                          },
                                          activeColor: Colors.white,
                                          inactiveTrackColor:
                                              Colors.grey.shade900,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            editQrCode
                                ? AnimationDropDownController(
                                    changeState: logoSwitch,
                                    durationTime: 100,
                                    firstChildeCard: Card(
                                      child: SizedBox(
                                        width: 410,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .library,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  try {
                                                    final image =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    if (image == null) return;
                                                    setState(() {
                                                      logo = image.path;
                                                    });
                                                  } on PlatformException catch (e) {
                                                    print(
                                                        'Failed to pick image: $e');
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.add_photo_alternate,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 0,
                                  ),
                            editQrCode
                                ? AnimationDropDownController(
                                    changeState: logoSwitch,
                                    durationTime: 200,
                                    firstChildeCard: Card(
                                      child: SizedBox(
                                        width: 410,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .camera,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  try {
                                                    final image =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                    if (image == null) return;
                                                    setState(() {
                                                      logo = image.path;
                                                    });
                                                  } on PlatformException catch (e) {
                                                    print(
                                                        'Failed to pick image: $e');
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.add_a_photo,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 0,
                                  ),
                            editQrCode
                                ? AnimationDropDownController(
                                    changeState: logoSwitch,
                                    durationTime: 300,
                                    firstChildeCard: Card(
                                      child: SizedBox(
                                        width: 410,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .padding,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                              Switch(
                                                value: logoPadding,
                                                onChanged: (value) {
                                                  setState(
                                                    () {
                                                      logoPadding = value;
                                                    },
                                                  );
                                                },
                                                activeColor: Colors.white,
                                                inactiveTrackColor:
                                                    Colors.grey.shade900,
                                                inactiveThumbColor:
                                                    Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 0,
                                  ),
                            editQrCode
                                ? AnimationDropDownController(
                                    changeState: logoSwitch,
                                    durationTime: 400,
                                    firstChildeCard: Card(
                                      child: SizedBox(
                                        width: 410,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .logo_size,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Slider(
                                                  min: 20.0,
                                                  max: 70.0,
                                                  value: logoSize,
                                                  onChanged: ((value) {
                                                    setState(
                                                      () {
                                                        logoSize = value;
                                                      },
                                                    );
                                                  }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 0,
                                  ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 500,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: 410,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .eyes_color,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                content: SingleChildScrollView(
                                                  child: ColorPicker(
                                                    hexInputBar: false,
                                                    labelTypes: const [],
                                                    pickerColor: eyesColor,
                                                    colorPickerWidth: 400,
                                                    pickerAreaBorderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                    paletteType:
                                                        PaletteType.hsl,
                                                    pickerAreaHeightPercent:
                                                        1.0,
                                                    onColorChanged:
                                                        (Color color) =>
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
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .ok,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.color_lens,
                                            size: 30,
                                            color: eyesColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 600,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: 410,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .data_color,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                content: SingleChildScrollView(
                                                  child: ColorPicker(
                                                    hexInputBar: false,
                                                    labelTypes: const [],
                                                    pickerColor: dataColor,
                                                    colorPickerWidth: 400,
                                                    pickerAreaBorderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                    paletteType:
                                                        PaletteType.hsl,
                                                    pickerAreaHeightPercent:
                                                        1.0,
                                                    onColorChanged:
                                                        (Color color) =>
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
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .ok,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.color_lens,
                                            size: 30,
                                            color: dataColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimationDropDownController(
                              changeState: editQrCode,
                              durationTime: 700,
                              firstChildeCard: Card(
                                child: SizedBox(
                                  width: 410,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .bg_color,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                content: SingleChildScrollView(
                                                  child: ColorPicker(
                                                    hexInputBar: false,
                                                    labelTypes: const [],
                                                    pickerColor:
                                                        backgroundColor,
                                                    colorPickerWidth: 400,
                                                    pickerAreaBorderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                    paletteType:
                                                        PaletteType.hsl,
                                                    pickerAreaHeightPercent:
                                                        1.0,
                                                    onColorChanged:
                                                        (Color color) =>
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
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .ok,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.color_lens,
                                            size: 30,
                                            color: backgroundColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<SaveQrCodeController>(
                              init: SaveQrCodeController(),
                              builder: (SaveQrCodeController controller) =>
                                  GetBuilder<VibrationController>(
                                init: VibrationController(),
                                builder:
                                    (VibrationController vibrationController) =>
                                        Card(
                                  color: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  child: SizedBox(
                                    width: 410,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        final image = await screenshotController
                                            .capture();
                                        controller.saveQrCode(image!, context);
                                        vibrationController.vibration();
                                      },
                                      icon: iconController(
                                        context,
                                        icon: Icons.save,
                                      ),
                                      label: labelController(
                                        context,
                                        label: AppLocalizations.of(context)!
                                            .save_qr_code,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<ShareQrCodeController>(
                              init: ShareQrCodeController(),
                              builder: (ShareQrCodeController controller) =>
                                  GetBuilder<VibrationController>(
                                init: VibrationController(),
                                builder:
                                    (VibrationController vibrationController) =>
                                        Card(
                                  color: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  child: SizedBox(
                                    width: 410,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        final image = await screenshotController
                                            .capture();
                                        controller.shareQrCode(image!);
                                        vibrationController.vibration();
                                      },
                                      icon: iconController(
                                        context,
                                        icon: Icons.share,
                                      ),
                                      label: labelController(
                                        context,
                                        label: AppLocalizations.of(context)!
                                            .share_qr_code,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<VibrationController>(
                              init: VibrationController(),
                              builder:
                                  (VibrationController vibrationController) =>
                                      Card(
                                color: Colors.transparent,
                                shadowColor: Colors.transparent,
                                child: SizedBox(
                                  width: 410,
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      final image =
                                          await screenshotController.capture();
                                      makeQrCodeListController
                                          .addItemToMakeQrCodeList(
                                        image!,
                                        context,
                                      );
                                      vibrationController.vibration();
                                    },
                                    icon: iconController(context,
                                        icon: Icons.favorite),
                                    label: labelController(
                                      context,
                                      label: AppLocalizations.of(context)!
                                          .add_to_favorite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

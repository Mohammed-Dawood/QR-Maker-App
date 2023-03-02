import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/app_bar_controller.dart';
import 'package:qr_maker_app/controller/background_controller.dart';
import 'package:qr_maker_app/controller/vibration_controller.dart';
import 'package:qr_maker_app/controller/save_qr_code_controller.dart';
import 'package:qr_maker_app/controller/share_qr_code_controller.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:qr_maker_app/controller/favorite/make_qr_code_list_controller.dart';

class StyleShareSaveFavoriteQrCode extends StatefulWidget {
  const StyleShareSaveFavoriteQrCode({
    Key? key,
    required this.image,
    required this.valueQr,
    required this.versionValueWithLogo,
  }) : super(key: key);

  final String image;
  final String valueQr;
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
  int selectScreenUpp = 0;
  int selectScreenDown = 0;
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
                bottomNavigationBar: GetBuilder<VibrationController>(
                  init: VibrationController(),
                  builder: (VibrationController vibrationController) =>
                      GetBuilder<SaveQrCodeController>(
                    init: SaveQrCodeController(),
                    builder: (SaveQrCodeController saveQrCodeController) =>
                        GetBuilder<ShareQrCodeController>(
                      init: ShareQrCodeController(),
                      builder: (ShareQrCodeController shareQrCodeController) =>
                          FloatingNavbar(
                        borderRadius: 5,
                        itemBorderRadius: 5,
                        currentIndex: 0,
                        selectedItemColor: selectScreenUpp == 0
                            ? Colors.white
                            : Colors.white30,
                        unselectedItemColor: selectScreenUpp == 0
                            ? Colors.white
                            : Colors.white30,
                        iconSize: isScreenWidth(context) ? 24 : 28,
                        fontSize: isScreenWidth(context) ? 12 : 14,
                        backgroundColor: Theme.of(context).primaryColor,
                        selectedBackgroundColor: Theme.of(context).primaryColor,
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        items: [
                          FloatingNavbarItem(
                            icon: Icons.save,
                            title: AppLocalizations.of(context)!.save,
                          ),
                          FloatingNavbarItem(
                            icon: Icons.share,
                            title: AppLocalizations.of(context)!.share,
                          ),
                          FloatingNavbarItem(
                            icon: Icons.add_box,
                            title: AppLocalizations.of(context)!.favorite,
                          ),
                        ],
                        onTap: (int screenNumber) async {
                          final image = await screenshotController.capture();
                          if (screenNumber == 0) {
                            saveQrCodeController.saveQrCode(image!, context);
                            vibrationController.vibration();
                          }
                          if (screenNumber == 1) {
                            shareQrCodeController.shareQrCode(image!);
                            vibrationController.vibration();
                          }
                          if (screenNumber == 2) {
                            final String valueQr = widget.valueQr;
                            makeQrCodeListController.addItemToMakeQrCodeList(
                              valueQr,
                              image!,
                              context,
                            );
                            vibrationController.vibration();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        FloatingNavbar(
                          borderRadius: 0,
                          itemBorderRadius: 5,
                          currentIndex: selectScreenUpp,
                          selectedBackgroundColor: Colors.white,
                          iconSize: isScreenWidth(context) ? 24 : 28,
                          fontSize: isScreenWidth(context) ? 12 : 14,
                          backgroundColor: Theme.of(context).primaryColor,
                          selectedItemColor: Theme.of(context).primaryColor,
                          unselectedItemColor: Colors.white,
                          margin: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0,
                          ),
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          items: [
                            FloatingNavbarItem(
                              icon: Icons.qr_code,
                              title: AppLocalizations.of(context)!.qr_code,
                            ),
                            FloatingNavbarItem(
                              icon: Icons.info,
                              title: AppLocalizations.of(context)!.info,
                            ),
                          ],
                          onTap: (int screenNumber) {
                            setState(
                              () {
                                selectScreenUpp = screenNumber;
                              },
                            );
                          },
                        ),
                        FloatingNavbar(
                          borderRadius: 0,
                          itemBorderRadius: 5,
                          currentIndex: selectScreenDown,
                          selectedBackgroundColor: selectScreenUpp == 0
                              ? Colors.white
                              : Colors.white10,
                          iconSize: isScreenWidth(context) ? 24 : 28,
                          fontSize: isScreenWidth(context) ? 12 : 14,
                          backgroundColor: Theme.of(context).primaryColor,
                          selectedItemColor: selectScreenUpp == 0
                              ? Theme.of(context).primaryColor
                              : Colors.white30,
                          unselectedItemColor: selectScreenUpp == 0
                              ? Colors.white
                              : Colors.white30,
                          margin: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0,
                          ),
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          items: [
                            FloatingNavbarItem(
                              icon: Icons.design_services,
                              title: AppLocalizations.of(context)!.design,
                            ),
                            FloatingNavbarItem(
                              icon: Icons.color_lens,
                              title: AppLocalizations.of(context)!.colors,
                            ),
                            FloatingNavbarItem(
                              icon: Icons.person,
                              title: AppLocalizations.of(context)!.logo,
                            ),
                          ],
                          onTap: (int screenNumber) {
                            selectScreenUpp == 0
                                ? setState(
                                    () {
                                      selectScreenDown = screenNumber;
                                    },
                                  )
                                : null;
                          },
                        ),
                      ],
                    ),
                    Center(
                      child: InkWell(
                        child: selectScreenUpp == 0
                            ? Card(
                                color: backgroundColor,
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Screenshot(
                                      controller: screenshotController,
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          QrImage(
                                            size: (isScreenWidth(context))
                                                ? 240
                                                : 400,
                                            gapless: gapSwitch,
                                            data: widget.valueQr,
                                            version: logoSwitch
                                                ? widget.versionValueWithLogo
                                                : versionValue,
                                            semanticsLabel: 'qr maker',
                                            backgroundColor: backgroundColor,
                                            constrainErrorBounds: true,
                                            // embeddedImageEmitsError: false,
                                            errorCorrectionLevel:
                                                QrErrorCorrectLevel.L,
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
                                                    (isScreenWidth(context)
                                                        ? 5
                                                        : 10)
                                                : 0,
                                            height: logoPadding
                                                ? logoSize +
                                                    (isScreenWidth(context)
                                                        ? 5
                                                        : 10)
                                                : 0,
                                          ),
                                          Image.asset(
                                            logo ?? widget.image,
                                            width: logoSwitch ? logoSize : 0,
                                            height: logoSwitch ? logoSize : 0,
                                          ),
                                        ],
                                      ),
                                    )),
                              )
                            : Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    width: (isScreenWidth(context)) ? 240 : 400,
                                    height:
                                        (isScreenWidth(context)) ? 240 : 400,
                                    child: Text(
                                      widget.valueQr,
                                      style: TextStyle(
                                        fontSize:
                                            (isScreenWidth(context)) ? 16 : 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        onTap: () async {
                          final String url = widget.valueQr;
                          if (await canLaunchUrlString(url)) {
                            await launchUrlString(url);
                          } else {
                            throw 'Could not launch ${widget.valueQr}';
                          }
                        },
                      ),
                    ),
                    selectScreenDown == 0
                        ? GetBuilder<VibrationController>(
                            init: VibrationController(),
                            builder:
                                (VibrationController vibrationController) =>
                                    FloatingNavbar(
                              borderRadius: 5,
                              itemBorderRadius: 5,
                              currentIndex: 0,
                              selectedItemColor: selectScreenUpp == 0
                                  ? Colors.white
                                  : Colors.white30,
                              unselectedItemColor: selectScreenUpp == 0
                                  ? Colors.white
                                  : Colors.white30,
                              iconSize: isScreenWidth(context) ? 24 : 28,
                              fontSize: isScreenWidth(context) ? 12 : 14,
                              backgroundColor: Theme.of(context).primaryColor,
                              selectedBackgroundColor:
                                  Theme.of(context).primaryColor,
                              margin: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 15,
                              ),
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              items: [
                                FloatingNavbarItem(
                                  icon: gapSwitch
                                      ? Icons.padding_rounded
                                      : Icons.padding,
                                  title: AppLocalizations.of(context)!.gap,
                                ),
                                FloatingNavbarItem(
                                  icon:
                                      eyesSwitch ? Icons.circle : Icons.square,
                                  title: AppLocalizations.of(context)!.eyes,
                                ),
                                FloatingNavbarItem(
                                  icon:
                                      dataSwitch ? Icons.circle : Icons.square,
                                  title: AppLocalizations.of(context)!.data,
                                ),
                              ],
                              onTap: selectScreenUpp == 0
                                  ? (int screenNumber) async {
                                      if (screenNumber == 0) {
                                        setState(() {
                                          gapSwitch = !gapSwitch;
                                        });
                                        vibrationController.vibration();
                                      }
                                      if (screenNumber == 1) {
                                        setState(() {
                                          eyesSwitch = !eyesSwitch;
                                        });
                                        vibrationController.vibration();
                                      }
                                      if (screenNumber == 2) {
                                        setState(() {
                                          dataSwitch = !dataSwitch;
                                        });
                                        vibrationController.vibration();
                                      }
                                    }
                                  : (int screenNumber) {},
                            ),
                          )
                        : selectScreenDown == 1
                            ? GetBuilder<VibrationController>(
                                init: VibrationController(),
                                builder:
                                    (VibrationController vibrationController) =>
                                        FloatingNavbar(
                                  borderRadius: 5,
                                  itemBorderRadius: 5,
                                  currentIndex: 0,
                                  selectedItemColor: selectScreenUpp == 0
                                      ? Colors.white
                                      : Colors.white30,
                                  unselectedItemColor: selectScreenUpp == 0
                                      ? Colors.white
                                      : Colors.white30,
                                  iconSize: isScreenWidth(context) ? 24 : 28,
                                  fontSize: isScreenWidth(context) ? 12 : 14,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  selectedBackgroundColor:
                                      Theme.of(context).primaryColor,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 15,
                                  ),
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  items: [
                                    FloatingNavbarItem(
                                      icon: Icons.color_lens,
                                      title: AppLocalizations.of(context)!
                                          .background,
                                    ),
                                    FloatingNavbarItem(
                                      icon: Icons.color_lens,
                                      title: AppLocalizations.of(context)!.eyes,
                                    ),
                                    FloatingNavbarItem(
                                      icon: Icons.color_lens,
                                      title: AppLocalizations.of(context)!.data,
                                    ),
                                  ],
                                  onTap: selectScreenUpp == 0
                                      ? (int screenNumber) async {
                                          if (screenNumber == 0) {
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
                                                  ),
                                                ],
                                              ),
                                            );
                                            vibrationController.vibration();
                                          }
                                          if (screenNumber == 1) {
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
                                            vibrationController.vibration();
                                          }
                                          if (screenNumber == 2) {
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
                                                  ),
                                                ],
                                              ),
                                            );
                                            vibrationController.vibration();
                                          }
                                        }
                                      : (int screenNumber) {},
                                ),
                              )
                            : GetBuilder<VibrationController>(
                                init: VibrationController(),
                                builder:
                                    (VibrationController vibrationController) =>
                                        FloatingNavbar(
                                  borderRadius: 5,
                                  itemBorderRadius: 5,
                                  currentIndex: 0,
                                  selectedItemColor: selectScreenUpp == 0
                                      ? Colors.white
                                      : Colors.white30,
                                  unselectedItemColor: selectScreenUpp == 0
                                      ? logoSwitch
                                          ? Colors.white
                                          : Colors.white30
                                      : Colors.white30,
                                  iconSize: isScreenWidth(context) ? 24 : 28,
                                  fontSize: isScreenWidth(context) ? 12 : 14,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  selectedBackgroundColor:
                                      Theme.of(context).primaryColor,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 15,
                                  ),
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  items: [
                                    FloatingNavbarItem(
                                      icon: logoSwitch
                                          ? Icons.person
                                          : Icons.person_off,
                                      title: AppLocalizations.of(context)!.logo,
                                    ),
                                    FloatingNavbarItem(
                                      icon: Icons.photo_library,
                                      title:
                                          AppLocalizations.of(context)!.library,
                                    ),
                                    FloatingNavbarItem(
                                      icon: Icons.photo_camera,
                                      title:
                                          AppLocalizations.of(context)!.camera,
                                    ),
                                  ],
                                  onTap: selectScreenUpp == 0
                                      ? (int screenNumber) async {
                                          if (screenNumber == 0) {
                                            logoSwitch = !logoSwitch;
                                            setState(() {
                                              logo = widget.image;
                                            });
                                            vibrationController.vibration();
                                          }
                                          if (screenNumber == 1) {
                                            if (logoSwitch == true) {
                                              try {
                                                final image =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                if (image == null) return;
                                                setState(() {
                                                  logo = image.path;
                                                });
                                              } on PlatformException catch (e) {
                                                print(
                                                    'Failed to pick image: $e');
                                              }
                                              vibrationController.vibration();
                                            }
                                          }
                                          if (screenNumber == 2) {
                                            if (logoSwitch == true) {
                                              try {
                                                final image =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                if (image == null) return;
                                                setState(() {
                                                  logo = image.path;
                                                });
                                              } on PlatformException catch (e) {
                                                print(
                                                    'Failed to pick image: $e');
                                              }
                                              vibrationController.vibration();
                                            }
                                          }
                                        }
                                      : (int screenNumber) {},
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
                bottomNavigationBar: GetBuilder<VibrationController>(
                  init: VibrationController(),
                  builder: (VibrationController vibrationController) =>
                      GetBuilder<SaveQrCodeController>(
                    init: SaveQrCodeController(),
                    builder: (SaveQrCodeController saveQrCodeController) =>
                        GetBuilder<ShareQrCodeController>(
                      init: ShareQrCodeController(),
                      builder: (ShareQrCodeController shareQrCodeController) =>
                          FloatingNavbar(
                        borderRadius: 5,
                        itemBorderRadius: 5,
                        currentIndex: 0,
                        selectedItemColor: selectScreenUpp == 0
                            ? Colors.white
                            : Colors.white30,
                        unselectedItemColor: selectScreenUpp == 0
                            ? Colors.white
                            : Colors.white30,
                        iconSize: 28,
                        fontSize: 14,
                        backgroundColor: Theme.of(context).primaryColor,
                        selectedBackgroundColor: Theme.of(context).primaryColor,
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        items: [
                          FloatingNavbarItem(
                            icon: Icons.save,
                            title: AppLocalizations.of(context)!.save,
                          ),
                          FloatingNavbarItem(
                            icon: Icons.share,
                            title: AppLocalizations.of(context)!.share,
                          ),
                          FloatingNavbarItem(
                            icon: Icons.add_box,
                            title: AppLocalizations.of(context)!.favorite,
                          ),
                        ],
                        onTap: (int screenNumber) async {
                          final image = await screenshotController.capture();
                          if (screenNumber == 0) {
                            saveQrCodeController.saveQrCode(image!, context);
                            vibrationController.vibration();
                          }
                          if (screenNumber == 1) {
                            shareQrCodeController.shareQrCode(image!);
                            vibrationController.vibration();
                          }
                          if (screenNumber == 2) {
                            final String valueQr = widget.valueQr;
                            makeQrCodeListController.addItemToMakeQrCodeList(
                              valueQr,
                              image!,
                              context,
                            );
                            vibrationController.vibration();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        FloatingNavbar(
                          borderRadius: 0,
                          itemBorderRadius: 5,
                          currentIndex: selectScreenUpp,
                          selectedBackgroundColor: Colors.white,
                          iconSize: 28,
                          fontSize: 14,
                          backgroundColor: Theme.of(context).primaryColor,
                          selectedItemColor: Theme.of(context).primaryColor,
                          unselectedItemColor: Colors.white,
                          margin: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0,
                          ),
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          items: [
                            FloatingNavbarItem(
                              icon: Icons.qr_code,
                              title: AppLocalizations.of(context)!.qr_code,
                            ),
                            FloatingNavbarItem(
                              icon: Icons.info,
                              title: AppLocalizations.of(context)!.info,
                            ),
                          ],
                          onTap: (int screenNumber) {
                            setState(
                              () {
                                selectScreenUpp = screenNumber;
                              },
                            );
                          },
                        ),
                        FloatingNavbar(
                          borderRadius: 0,
                          itemBorderRadius: 5,
                          currentIndex: selectScreenDown,
                          selectedBackgroundColor: selectScreenUpp == 0
                              ? Colors.white
                              : Colors.white10,
                          iconSize: 28,
                          fontSize: 14,
                          backgroundColor: Theme.of(context).primaryColor,
                          selectedItemColor: selectScreenUpp == 0
                              ? Theme.of(context).primaryColor
                              : Colors.white30,
                          unselectedItemColor: selectScreenUpp == 0
                              ? Colors.white
                              : Colors.white30,
                          margin: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0,
                          ),
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          items: [
                            FloatingNavbarItem(
                              icon: Icons.design_services,
                              title: AppLocalizations.of(context)!.design,
                            ),
                            FloatingNavbarItem(
                              icon: Icons.color_lens,
                              title: AppLocalizations.of(context)!.colors,
                            ),
                            FloatingNavbarItem(
                              icon: Icons.person,
                              title: AppLocalizations.of(context)!.logo,
                            ),
                          ],
                          onTap: (int screenNumber) {
                            selectScreenUpp == 0
                                ? setState(
                                    () {
                                      selectScreenDown = screenNumber;
                                    },
                                  )
                                : null;
                          },
                        ),
                      ],
                    ),
                    Center(
                      child: InkWell(
                        child: selectScreenUpp == 0
                            ? Card(
                                color: backgroundColor,
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Screenshot(
                                      controller: screenshotController,
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          QrImage(
                                            size: (isScreenWidth(context))
                                                ? 240
                                                : 400,
                                            gapless: gapSwitch,
                                            data: widget.valueQr,
                                            version: logoSwitch
                                                ? widget.versionValueWithLogo
                                                : versionValue,
                                            semanticsLabel: 'qr maker',
                                            backgroundColor: backgroundColor,
                                            constrainErrorBounds: true,
                                            // embeddedImageEmitsError: false,
                                            errorCorrectionLevel:
                                                QrErrorCorrectLevel.L,
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
                                                    (isScreenWidth(context)
                                                        ? 5
                                                        : 10)
                                                : 0,
                                            height: logoPadding
                                                ? logoSize +
                                                    (isScreenWidth(context)
                                                        ? 5
                                                        : 10)
                                                : 0,
                                          ),
                                          Image.asset(
                                            logo ?? widget.image,
                                            width: logoSwitch ? logoSize : 0,
                                            height: logoSwitch ? logoSize : 0,
                                          ),
                                        ],
                                      ),
                                    )),
                              )
                            : Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    width: (isScreenWidth(context)) ? 240 : 400,
                                    height:
                                        (isScreenWidth(context)) ? 240 : 400,
                                    child: Text(
                                      widget.valueQr,
                                      style: TextStyle(
                                        fontSize:
                                            (isScreenWidth(context)) ? 16 : 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        onTap: () async {
                          final String url = widget.valueQr;
                          if (await canLaunchUrlString(url)) {
                            await launchUrlString(url);
                          } else {
                            throw 'Could not launch ${widget.valueQr}';
                          }
                        },
                      ),
                    ),
                    selectScreenDown == 0
                        ? GetBuilder<VibrationController>(
                            init: VibrationController(),
                            builder:
                                (VibrationController vibrationController) =>
                                    FloatingNavbar(
                              borderRadius: 5,
                              itemBorderRadius: 5,
                              currentIndex: 0,
                              selectedItemColor: selectScreenUpp == 0
                                  ? Colors.white
                                  : Colors.white30,
                              unselectedItemColor: selectScreenUpp == 0
                                  ? Colors.white
                                  : Colors.white30,
                              iconSize: 28,
                              fontSize: 14,
                              backgroundColor: Theme.of(context).primaryColor,
                              selectedBackgroundColor:
                                  Theme.of(context).primaryColor,
                              margin: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 15,
                              ),
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              items: [
                                FloatingNavbarItem(
                                  icon: gapSwitch
                                      ? Icons.padding_rounded
                                      : Icons.padding,
                                  title: AppLocalizations.of(context)!.gap,
                                ),
                                FloatingNavbarItem(
                                  icon:
                                      eyesSwitch ? Icons.circle : Icons.square,
                                  title: AppLocalizations.of(context)!.eyes,
                                ),
                                FloatingNavbarItem(
                                  icon:
                                      dataSwitch ? Icons.circle : Icons.square,
                                  title: AppLocalizations.of(context)!.data,
                                ),
                              ],
                              onTap: selectScreenUpp == 0
                                  ? (int screenNumber) async {
                                      if (screenNumber == 0) {
                                        setState(() {
                                          gapSwitch = !gapSwitch;
                                        });
                                        vibrationController.vibration();
                                      }
                                      if (screenNumber == 1) {
                                        setState(() {
                                          eyesSwitch = !eyesSwitch;
                                        });
                                        vibrationController.vibration();
                                      }
                                      if (screenNumber == 2) {
                                        setState(() {
                                          dataSwitch = !dataSwitch;
                                        });
                                        vibrationController.vibration();
                                      }
                                    }
                                  : (int screenNumber) {},
                            ),
                          )
                        : selectScreenDown == 1
                            ? GetBuilder<VibrationController>(
                                init: VibrationController(),
                                builder:
                                    (VibrationController vibrationController) =>
                                        FloatingNavbar(
                                  borderRadius: 5,
                                  itemBorderRadius: 5,
                                  currentIndex: 0,
                                  selectedItemColor: selectScreenUpp == 0
                                      ? Colors.white
                                      : Colors.white30,
                                  unselectedItemColor: selectScreenUpp == 0
                                      ? Colors.white
                                      : Colors.white30,
                                  iconSize: 28,
                                  fontSize: 14,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  selectedBackgroundColor:
                                      Theme.of(context).primaryColor,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 15,
                                  ),
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  items: [
                                    FloatingNavbarItem(
                                      icon: Icons.color_lens,
                                      title: AppLocalizations.of(context)!
                                          .background,
                                    ),
                                    FloatingNavbarItem(
                                      icon: Icons.color_lens,
                                      title: AppLocalizations.of(context)!.eyes,
                                    ),
                                    FloatingNavbarItem(
                                      icon: Icons.color_lens,
                                      title: AppLocalizations.of(context)!.data,
                                    ),
                                  ],
                                  onTap: selectScreenUpp == 0
                                      ? (int screenNumber) async {
                                          if (screenNumber == 0) {
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
                                                  ),
                                                ],
                                              ),
                                            );
                                            vibrationController.vibration();
                                          }
                                          if (screenNumber == 1) {
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
                                            vibrationController.vibration();
                                          }
                                          if (screenNumber == 2) {
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
                                                  ),
                                                ],
                                              ),
                                            );
                                            vibrationController.vibration();
                                          }
                                        }
                                      : (int screenNumber) {},
                                ),
                              )
                            : GetBuilder<VibrationController>(
                                init: VibrationController(),
                                builder:
                                    (VibrationController vibrationController) =>
                                        FloatingNavbar(
                                  borderRadius: 5,
                                  itemBorderRadius: 5,
                                  currentIndex: 0,
                                  selectedItemColor: selectScreenUpp == 0
                                      ? Colors.white
                                      : Colors.white30,
                                  unselectedItemColor: selectScreenUpp == 0
                                      ? logoSwitch
                                          ? Colors.white
                                          : Colors.white30
                                      : Colors.white30,
                                  iconSize: 28,
                                  fontSize: 14,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  selectedBackgroundColor:
                                      Theme.of(context).primaryColor,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 15,
                                  ),
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  items: [
                                    FloatingNavbarItem(
                                      icon: logoSwitch
                                          ? Icons.person
                                          : Icons.person_off,
                                      title: AppLocalizations.of(context)!.logo,
                                    ),
                                    FloatingNavbarItem(
                                      icon: Icons.photo_library,
                                      title:
                                          AppLocalizations.of(context)!.library,
                                    ),
                                    FloatingNavbarItem(
                                      icon: Icons.photo_camera,
                                      title:
                                          AppLocalizations.of(context)!.camera,
                                    ),
                                  ],
                                  onTap: selectScreenUpp == 0
                                      ? (int screenNumber) async {
                                          if (screenNumber == 0) {
                                            logoSwitch = !logoSwitch;
                                            setState(() {
                                              logo = widget.image;
                                            });
                                            vibrationController.vibration();
                                          }
                                          if (screenNumber == 1) {
                                            if (logoSwitch == true) {
                                              try {
                                                final image =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                if (image == null) return;
                                                setState(() {
                                                  logo = image.path;
                                                });
                                              } on PlatformException catch (e) {
                                                print(
                                                    'Failed to pick image: $e');
                                              }
                                              vibrationController.vibration();
                                            }
                                          }
                                          if (screenNumber == 2) {
                                            if (logoSwitch == true) {
                                              try {
                                                final image =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                if (image == null) return;
                                                setState(() {
                                                  logo = image.path;
                                                });
                                              } on PlatformException catch (e) {
                                                print(
                                                    'Failed to pick image: $e');
                                              }
                                              vibrationController.vibration();
                                            }
                                          }
                                        }
                                      : (int screenNumber) {},
                                ),
                              ),
                  ],
                ),
              ),
            ),
          );
  }
}

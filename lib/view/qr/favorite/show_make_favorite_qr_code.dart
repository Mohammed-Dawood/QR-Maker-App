import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/icons_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/labels_controller.dart';
import 'package:qr_maker_app/controller/language_controller.dart';
import 'package:qr_maker_app/controller/background_controller.dart';
import 'package:qr_maker_app/controller/vibration_controller.dart';
import 'package:qr_maker_app/controller/save_qr_code_controller.dart';
import 'package:qr_maker_app/controller/share_qr_code_controller.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:qr_maker_app/controller/favorite/make_qr_code_list_controller.dart';

class ShowMakeFavoriteQrCode extends StatefulWidget {
  const ShowMakeFavoriteQrCode({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<ShowMakeFavoriteQrCode> createState() => _ShowMakeFavoriteQrCodeState();
}

class _ShowMakeFavoriteQrCodeState extends State<ShowMakeFavoriteQrCode> {
  int? qrIndex;
  int selectScreen = 0;
  LanguageController languageController = Get.find();
  ScreenshotController screenshotController = ScreenshotController();
  TextEditingController textEditingController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    qrIndex = qrIndex ?? widget.index;

    return MediaQuery.of(context).orientation == Orientation.portrait
        ? GetBuilder<ThemeController>(
            init: ThemeController(),
            builder: (ThemeController controller) => Container(
              alignment: Alignment.center,
              decoration: backgroundController(controller),
              child: Scaffold(
                appBar: AppBar(
                  title: GetBuilder<MakeQrCodeListController>(
                    init: MakeQrCodeListController(),
                    builder: (MakeQrCodeListController controller) => Text(
                      GetStorage().read(
                            controller.makeQrImageList[qrIndex!],
                          ) ??
                          AppLocalizations.of(context)!.change_qr_code_name,
                      style: TextStyle(
                        fontSize: (isScreenWidth(context)) ? 18 : 24,
                      ),
                    ),
                  ),
                  iconTheme: IconThemeData(
                    size: (isScreenWidth(context)) ? 22 : 26,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(
                              AppLocalizations.of(context)!.write_qr_code_name,
                              style: (isScreenWidth(context))
                                  ? Theme.of(context).textTheme.displaySmall
                                  : Theme.of(context).textTheme.displayMedium,
                            ),
                            content: SingleChildScrollView(
                              child: TextFormField(
                                maxLines: 1,
                                cursorWidth: 3,
                                controller: textEditingController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .qr_code_name,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.qr_code,
                                  ),
                                  suffixIcon: textEditingController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              textEditingController.clear(),
                                          icon: suffixIconController(
                                            context,
                                            icon: Icons.close,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.displaySmall
                                      : Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                ),
                              ),
                              GetBuilder<MakeQrCodeListController>(
                                init: MakeQrCodeListController(),
                                builder:
                                    (MakeQrCodeListController controller) =>
                                        TextButton(
                                  onPressed: () {
                                    setState(() {
                                      GetStorage().write(
                                        controller.makeQrImageList[qrIndex!],
                                        textEditingController.text,
                                      );
                                    });
                                    Get.back();
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.ok,
                                    style: (isScreenWidth(context))
                                        ? Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: GetBuilder<VibrationController>(
                  init: VibrationController(),
                  builder: (VibrationController vibrationController) =>
                      GetBuilder<MakeQrCodeListController>(
                    init: MakeQrCodeListController(),
                    builder:
                        (MakeQrCodeListController makeQrCodeListController) =>
                            FloatingNavbar(
                      borderRadius: 5,
                      itemBorderRadius: 5,
                      currentIndex: 0,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.white,
                      iconSize: isScreenWidth(context) ? 24 : 28,
                      fontSize: isScreenWidth(context) ? 12 : 14,
                      backgroundColor: Theme.of(context).primaryColor,
                      selectedBackgroundColor: Theme.of(context).primaryColor,
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 15,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 10,
                      ),
                      items: [
                        FloatingNavbarItem(
                          icon: Icons.arrow_back_ios,
                          title: AppLocalizations.of(context)!.previous,
                        ),
                        FloatingNavbarItem(
                          icon: Icons.delete,
                          title: AppLocalizations.of(context)!.delete,
                        ),
                        FloatingNavbarItem(
                          icon: Icons.arrow_forward_ios,
                          title: AppLocalizations.of(context)!.next,
                        ),
                      ],
                      onTap: (int screenNumber) {
                        if (screenNumber == 0) {
                          setState(
                            () {
                              if (qrIndex! > 0) {
                                qrIndex = qrIndex! - 1;
                              } else {
                                qrIndex = makeQrCodeListController
                                        .makeQrCodeList.length -
                                    1;
                              }
                            },
                          );
                        }
                        if (screenNumber == 1) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                AppLocalizations.of(context)!
                                    .delete_qr_code_text,
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.displaySmall
                                    : Theme.of(context).textTheme.displayMedium,
                              ),
                              content: Text(
                                AppLocalizations.of(context)!
                                    .delete_qr_code_message,
                                style: (isScreenWidth(context))
                                    ? const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      )
                                    : const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text(
                                    AppLocalizations.of(context)!.cancel,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // GetStorage().remove(
                                    //   makeQrCodeListController
                                    //       .makeQrCodeList[qrIndex!],
                                    // );
                                    makeQrCodeListController
                                        .deleteItemFromMakeQrCodeList(qrIndex!);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.delete,
                                  ),
                                ),
                              ],
                            ),
                          );
                          vibrationController.vibration();
                        }
                        if (screenNumber == 2) {
                          setState(
                            () {
                              if (qrIndex! <
                                  makeQrCodeListController
                                          .makeQrCodeList.length -
                                      1) {
                                qrIndex = qrIndex! + 1;
                              } else {
                                qrIndex = 0;
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    FloatingNavbar(
                      borderRadius: 0,
                      itemBorderRadius: 5,
                      currentIndex: selectScreen,
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
                            selectScreen = screenNumber;
                          },
                        );
                      },
                    ),
                    Center(
                      child: GetBuilder<MakeQrCodeListController>(
                        init: MakeQrCodeListController(),
                        builder: (MakeQrCodeListController
                                makeQrCodeListController) =>
                            InkWell(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: (isScreenWidth(context)) ? 250 : 300,
                                height: (isScreenWidth(context)) ? 250 : 300,
                                child: selectScreen == 0
                                    ? Screenshot(
                                        controller: screenshotController,
                                        child: Image.memory(
                                          Uint8List.fromList(
                                            makeQrCodeListController
                                                .makeQrImageList[qrIndex!]
                                                .codeUnits,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        makeQrCodeListController
                                            .makeQrCodeList[qrIndex!],
                                        style: TextStyle(
                                          fontSize: (isScreenWidth(context))
                                              ? 16
                                              : 22,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            final String url = makeQrCodeListController
                                .makeQrCodeList[qrIndex!];
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
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
                appBar: AppBar(
                  title: GetBuilder<MakeQrCodeListController>(
                    init: MakeQrCodeListController(),
                    builder: (MakeQrCodeListController controller) => Text(
                      GetStorage().read(
                            controller.makeQrImageList[qrIndex!],
                          ) ??
                          AppLocalizations.of(context)!.change_qr_code_name,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  iconTheme: IconThemeData(
                    size: 26,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(
                              AppLocalizations.of(context)!.write_qr_code_name,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            content: SingleChildScrollView(
                              child: TextFormField(
                                maxLines: 1,
                                cursorWidth: 3,
                                controller: textEditingController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .qr_code_name,
                                  prefixIcon: prefixIconController(
                                    context,
                                    icon: Icons.qr_code,
                                  ),
                                  suffixIcon: textEditingController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              textEditingController.clear(),
                                          icon: suffixIconController(
                                            context,
                                            icon: Icons.close,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                              GetBuilder<MakeQrCodeListController>(
                                init: MakeQrCodeListController(),
                                builder:
                                    (MakeQrCodeListController controller) =>
                                        TextButton(
                                  onPressed: () {
                                    setState(() {
                                      GetStorage().write(
                                          controller.makeQrImageList[qrIndex!],
                                          textEditingController.text);
                                    });
                                    Get.back();
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.ok,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: GetBuilder<VibrationController>(
                  init: VibrationController(),
                  builder: (VibrationController vibrationController) =>
                      GetBuilder<MakeQrCodeListController>(
                    init: MakeQrCodeListController(),
                    builder:
                        (MakeQrCodeListController makeQrCodeListController) =>
                            FloatingNavbar(
                      borderRadius: 5,
                      itemBorderRadius: 5,
                      currentIndex: 0,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.white,
                      iconSize: 28,
                      fontSize: 14,
                      backgroundColor: Theme.of(context).primaryColor,
                      selectedBackgroundColor: Theme.of(context).primaryColor,
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 15,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 10,
                      ),
                      items: [
                        FloatingNavbarItem(
                          icon: Icons.arrow_back_ios,
                          title: AppLocalizations.of(context)!.previous,
                        ),
                        FloatingNavbarItem(
                          icon: Icons.delete,
                          title: AppLocalizations.of(context)!.delete,
                        ),
                        FloatingNavbarItem(
                          icon: Icons.arrow_forward_ios,
                          title: AppLocalizations.of(context)!.next,
                        ),
                      ],
                      onTap: (int screenNumber) {
                        if (screenNumber == 0) {
                          setState(
                            () {
                              if (qrIndex! > 0) {
                                qrIndex = qrIndex! - 1;
                              } else {
                                qrIndex = makeQrCodeListController
                                        .makeQrCodeList.length -
                                    1;
                              }
                            },
                          );
                        }
                        if (screenNumber == 1) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                AppLocalizations.of(context)!
                                    .delete_qr_code_text,
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.displaySmall
                                    : Theme.of(context).textTheme.displayMedium,
                              ),
                              content: Text(
                                AppLocalizations.of(context)!
                                    .delete_qr_code_message,
                                style: (isScreenWidth(context))
                                    ? const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      )
                                    : const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text(
                                    AppLocalizations.of(context)!.cancel,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // GetStorage().remove(
                                    //   makeQrCodeListController
                                    //       .makeQrCodeList[qrIndex!],
                                    // );
                                    makeQrCodeListController
                                        .deleteItemFromMakeQrCodeList(qrIndex!);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.delete,
                                  ),
                                ),
                              ],
                            ),
                          );
                          vibrationController.vibration();
                        }
                        if (screenNumber == 2) {
                          setState(
                            () {
                              if (qrIndex! <
                                  makeQrCodeListController
                                          .makeQrCodeList.length -
                                      1) {
                                qrIndex = qrIndex! + 1;
                              } else {
                                qrIndex = 0;
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    FloatingNavbar(
                      borderRadius: 0,
                      itemBorderRadius: 5,
                      currentIndex: selectScreen,
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
                            selectScreen = screenNumber;
                          },
                        );
                      },
                    ),
                    Center(
                      child: GetBuilder<MakeQrCodeListController>(
                        init: MakeQrCodeListController(),
                        builder: (MakeQrCodeListController
                                makeQrCodeListController) =>
                            InkWell(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: 300,
                                height: 300,
                                child: selectScreen == 0
                                    ? Screenshot(
                                        controller: screenshotController,
                                        child: Image.memory(
                                          Uint8List.fromList(
                                            makeQrCodeListController
                                                .makeQrImageList[qrIndex!]
                                                .codeUnits,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        makeQrCodeListController
                                            .makeQrCodeList[qrIndex!],
                                        style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            final String url = makeQrCodeListController
                                .makeQrCodeList[qrIndex!];
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
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









//  Card(
//                             color: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                             child: SizedBox(
//                               width: (isScreenWidth(context)) ? 250 : 410,
//                               child: Row(
//                                 children: [
//                                   GetBuilder<MakeQrCodeListController>(
//                                     init: MakeQrCodeListController(),
//                                     builder:
//                                         (MakeQrCodeListController controller) =>
//                                             Expanded(
//                                       child: ElevatedButton.icon(
//                                         onPressed: () {
//                                           setState(() {
//                                             if (qrIndex! > 0) {
//                                               qrIndex = qrIndex! - 1;
//                                             } else {
//                                               qrIndex = controller
//                                                       .makeQrImageList.length -
//                                                   1;
//                                             }
//                                           });
//                                         },
//                                         icon: iconController(
//                                           context,
//                                           icon: Icons.arrow_back_ios,
//                                         ),
//                                         label: labelController(
//                                           context,
//                                           label: AppLocalizations.of(context)!
//                                               .previous,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   GetBuilder<MakeQrCodeListController>(
//                                     init: MakeQrCodeListController(),
//                                     builder:
//                                         (MakeQrCodeListController controller) =>
//                                             Expanded(
//                                       child: Directionality(
//                                         textDirection: languageController
//                                                     .currentLanguage ==
//                                                 "ar"
//                                             ? TextDirection.ltr
//                                             : TextDirection.rtl,
//                                         child: ElevatedButton.icon(
//                                           onPressed: () {
//                                             setState(() {
//                                               if ((qrIndex!) <
//                                                   controller.makeQrImageList
//                                                           .length -
//                                                       1) {
//                                                 qrIndex = qrIndex! + 1;
//                                               } else {
//                                                 qrIndex = 0;
//                                               }
//                                             });
//                                           },
//                                           icon: iconController(
//                                             context,
//                                             icon: Icons.arrow_back_ios,
//                                           ),
//                                           label: labelController(
//                                             context,
//                                             label: AppLocalizations.of(context)!
//                                                 .next,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           GetBuilder<SaveQrCodeController>(
//                             init: SaveQrCodeController(),
//                             builder: (SaveQrCodeController controller) =>
//                                 GetBuilder<VibrationController>(
//                               init: VibrationController(),
//                               builder:
//                                   (VibrationController vibrationController) =>
//                                       Card(
//                                 color: Colors.transparent,
//                                 shadowColor: Colors.transparent,
//                                 child: SizedBox(
//                                   width: (isScreenWidth(context)) ? 250 : 410,
//                                   child: ElevatedButton.icon(
//                                     onPressed: () async {
//                                       final image =
//                                           await screenshotController.capture();
//                                       controller.saveQrCode(image!, context);
//                                       vibrationController.vibration();
//                                     },
//                                     icon: iconController(
//                                       context,
//                                       icon: Icons.save,
//                                     ),
//                                     label: labelController(
//                                       context,
//                                       label: AppLocalizations.of(context)!
//                                           .save_qr_code,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           GetBuilder<ShareQrCodeController>(
//                             init: ShareQrCodeController(),
//                             builder: (ShareQrCodeController controller) =>
//                                 GetBuilder<VibrationController>(
//                               init: VibrationController(),
//                               builder:
//                                   (VibrationController vibrationController) =>
//                                       Card(
//                                 color: Colors.transparent,
//                                 shadowColor: Colors.transparent,
//                                 child: SizedBox(
//                                   width: (isScreenWidth(context)) ? 250 : 410,
//                                   child: ElevatedButton.icon(
//                                     onPressed: () async {
//                                       final image =
//                                           await screenshotController.capture();
//                                       controller.shareQrCode(image!);
//                                       vibrationController.vibration();
//                                     },
//                                     icon: iconController(
//                                       context,
//                                       icon: Icons.share,
//                                     ),
//                                     label: labelController(
//                                       context,
//                                       label: AppLocalizations.of(context)!
//                                           .share_qr_code,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           GetBuilder<VibrationController>(
//                             init: VibrationController(),
//                             builder:
//                                 (VibrationController vibrationController) =>
//                                     Card(
//                               color: Colors.transparent,
//                               shadowColor: Colors.transparent,
//                               child: SizedBox(
//                                 width: (isScreenWidth(context)) ? 250 : 410,
//                                 child: ElevatedButton.icon(
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) =>
//                                           AlertDialog(
//                                         title: Text(
//                                           AppLocalizations.of(context)!
//                                               .delete_qr_code_text,
//                                           style: (isScreenWidth(context))
//                                               ? Theme.of(context)
//                                                   .textTheme
//                                                   .displaySmall
//                                               : Theme.of(context)
//                                                   .textTheme
//                                                   .displayMedium,
//                                         ),
//                                         content: Text(
//                                           AppLocalizations.of(context)!
//                                               .delete_qr_code_message,
//                                           style: (isScreenWidth(context))
//                                               ? const TextStyle(
//                                                   fontSize: 14,
//                                                   color: Colors.white,
//                                                 )
//                                               : const TextStyle(
//                                                   fontSize: 20,
//                                                   color: Colors.white,
//                                                 ),
//                                         ),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () => Get.back(),
//                                             child: Text(
//                                               AppLocalizations.of(context)!
//                                                   .cancel,
//                                             ),
//                                           ),
//                                           GetBuilder<MakeQrCodeListController>(
//                                             init: MakeQrCodeListController(),
//                                             builder: (MakeQrCodeListController
//                                                     controller) =>
//                                                 TextButton(
//                                               onPressed: () async {
//                                                 GetStorage().remove(
//                                                   controller.makeQrImageList[
//                                                       qrIndex!],
//                                                 );
//                                                 controller
//                                                     .deleteItemFromMakeQrCodeList(
//                                                   qrIndex!,
//                                                 );
//                                               },
//                                               child: Text(
//                                                 AppLocalizations.of(context)!
//                                                     .delete,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                     vibrationController.vibration();
//                                   },
//                                   icon: iconController(
//                                     context,
//                                     icon: Icons.delete,
//                                   ),
//                                   label: labelController(
//                                     context,
//                                     label: AppLocalizations.of(context)!
//                                         .delete_qr_code,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),







// body: Center(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             bottom: 20,
//                           ),
//                           child: Card(
//                             child: SizedBox(
//                               height: 410,
//                               width: 410,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(5.0),
//                                 child: Screenshot(
//                                   controller: screenshotController,
//                                   child: GetBuilder<MakeQrCodeListController>(
//                                     init: MakeQrCodeListController(),
//                                     builder:
//                                         (MakeQrCodeListController controller) =>
//                                             Image.memory(
//                                       Uint8List.fromList(
//                                         controller.makeQrImageList[qrIndex!]
//                                             .codeUnits,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Card(
//                           color: Colors.transparent,
//                           shadowColor: Colors.transparent,
//                           child: SizedBox(
//                             width: 410,
//                             child: Row(
//                               children: [
//                                 GetBuilder<MakeQrCodeListController>(
//                                   init: MakeQrCodeListController(),
//                                   builder:
//                                       (MakeQrCodeListController controller) =>
//                                           Expanded(
//                                     child: ElevatedButton.icon(
//                                       onPressed: () {
//                                         setState(() {
//                                           if (qrIndex! > 0) {
//                                             qrIndex = qrIndex! - 1;
//                                           } else {
//                                             qrIndex = controller
//                                                     .makeQrImageList.length -
//                                                 1;
//                                           }
//                                         });
//                                       },
//                                       icon: iconController(
//                                         context,
//                                         icon: Icons.arrow_back_ios,
//                                       ),
//                                       label: labelController(
//                                         context,
//                                         label: AppLocalizations.of(context)!
//                                             .previous,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 GetBuilder<MakeQrCodeListController>(
//                                   init: MakeQrCodeListController(),
//                                   builder:
//                                       (MakeQrCodeListController controller) =>
//                                           Expanded(
//                                     child: Directionality(
//                                       textDirection:
//                                           languageController.currentLanguage ==
//                                                   "ar"
//                                               ? TextDirection.ltr
//                                               : TextDirection.rtl,
//                                       child: ElevatedButton.icon(
//                                         onPressed: () {
//                                           setState(() {
//                                             if (qrIndex! <
//                                                 controller.makeQrImageList
//                                                         .length -
//                                                     1) {
//                                               qrIndex = qrIndex! + 1;
//                                             } else {
//                                               qrIndex = 0;
//                                             }
//                                           });
//                                         },
//                                         icon: iconController(
//                                           context,
//                                           icon: Icons.arrow_back_ios,
//                                         ),
//                                         label: labelController(
//                                           context,
//                                           label: AppLocalizations.of(context)!
//                                               .next,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         GetBuilder<SaveQrCodeController>(
//                           init: SaveQrCodeController(),
//                           builder: (SaveQrCodeController controller) =>
//                               GetBuilder<VibrationController>(
//                             init: VibrationController(),
//                             builder:
//                                 (VibrationController vibrationController) =>
//                                     Card(
//                               color: Colors.transparent,
//                               shadowColor: Colors.transparent,
//                               child: SizedBox(
//                                 width: 410,
//                                 child: ElevatedButton.icon(
//                                   onPressed: () async {
//                                     final image =
//                                         await screenshotController.capture();
//                                     controller.saveQrCode(image!, context);
//                                     vibrationController.vibration();
//                                   },
//                                   icon: iconController(
//                                     context,
//                                     icon: Icons.save,
//                                   ),
//                                   label: labelController(
//                                     context,
//                                     label: AppLocalizations.of(context)!
//                                         .save_qr_code,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         GetBuilder<ShareQrCodeController>(
//                           init: ShareQrCodeController(),
//                           builder: (ShareQrCodeController controller) =>
//                               GetBuilder<VibrationController>(
//                             init: VibrationController(),
//                             builder:
//                                 (VibrationController vibrationController) =>
//                                     Card(
//                               color: Colors.transparent,
//                               shadowColor: Colors.transparent,
//                               child: SizedBox(
//                                 width: 410,
//                                 child: ElevatedButton.icon(
//                                   onPressed: () async {
//                                     final image =
//                                         await screenshotController.capture();
//                                     controller.shareQrCode(image!);
//                                     vibrationController.vibration();
//                                   },
//                                   icon: iconController(
//                                     context,
//                                     icon: Icons.share,
//                                   ),
//                                   label: labelController(
//                                     context,
//                                     label: AppLocalizations.of(context)!
//                                         .share_qr_code,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         GetBuilder<VibrationController>(
//                           init: VibrationController(),
//                           builder: (VibrationController vibrationController) =>
//                               Card(
//                             color: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                             child: SizedBox(
//                               width: 410,
//                               child: ElevatedButton.icon(
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) =>
//                                         AlertDialog(
//                                       title: Text(
//                                         AppLocalizations.of(context)!
//                                             .delete_qr_code_text,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .displayMedium,
//                                       ),
//                                       content: Text(
//                                         AppLocalizations.of(context)!
//                                             .delete_qr_code_message,
//                                         style: const TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () => Get.back(),
//                                           child: Text(
//                                             AppLocalizations.of(context)!
//                                                 .cancel,
//                                           ),
//                                         ),
//                                         GetBuilder<MakeQrCodeListController>(
//                                           init: MakeQrCodeListController(),
//                                           builder: (MakeQrCodeListController
//                                                   controller) =>
//                                               TextButton(
//                                             onPressed: () async {
//                                               GetStorage().remove(
//                                                 controller
//                                                     .makeQrImageList[qrIndex!],
//                                               );
//                                               controller
//                                                   .deleteItemFromMakeQrCodeList(
//                                                 qrIndex!,
//                                               );
//                                             },
//                                             child: Text(
//                                               AppLocalizations.of(context)!
//                                                   .delete,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                   vibrationController.vibration();
//                                 },
//                                 icon: iconController(
//                                   context,
//                                   icon: Icons.delete,
//                                 ),
//                                 label: labelController(
//                                   context,
//                                   label: AppLocalizations.of(context)!
//                                       .delete_qr_code,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
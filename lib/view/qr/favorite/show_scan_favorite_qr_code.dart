import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/vibration_controller.dart';
import 'package:qr_maker_app/controller/background_controller.dart';
import 'package:qr_maker_app/controller/make_qr_code_controller.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:qr_maker_app/controller/favorite/scan_qr_code_list_controller.dart';

class ShowScanFavoriteQrCode extends StatefulWidget {
  const ShowScanFavoriteQrCode({
    Key? key,
    required this.index,
    required this.length,
    required this.valueQr,
  }) : super(key: key);

  final int index;
  final int length;
  final String valueQr;

  @override
  State<ShowScanFavoriteQrCode> createState() => _ShowScanFavoriteQrCodeState();
}

class _ShowScanFavoriteQrCodeState extends State<ShowScanFavoriteQrCode> {
  int? qrIndex;
  int selectScreen = 0;

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
                  title: Text(
                    AppLocalizations.of(context)!.qr_code,
                    style: TextStyle(
                      fontSize: (isScreenWidth(context)) ? 18 : 24,
                    ),
                  ),
                  iconTheme: IconThemeData(
                    size: (isScreenWidth(context)) ? 24 : 28,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                bottomNavigationBar: GetBuilder<VibrationController>(
                  init: VibrationController(),
                  builder: (VibrationController vibrationController) =>
                      GetBuilder<ScanQrCodeListController>(
                    init: ScanQrCodeListController(),
                    builder:
                        (ScanQrCodeListController scanQrCodeListController) =>
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
                                qrIndex = scanQrCodeListController
                                        .scanQrCodeList.length -
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
                                    //   scanQrCodeListController
                                    //       .scanQrCodeList[qrIndex!],
                                    // );
                                    scanQrCodeListController
                                        .deleteItemFromScanQrCodeList(qrIndex!);
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
                                  scanQrCodeListController
                                          .scanQrCodeList.length -
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
                      child: GetBuilder<ScanQrCodeListController>(
                        init: ScanQrCodeListController(),
                        builder: (ScanQrCodeListController
                                scanQrCodeListController) =>
                            InkWell(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: (isScreenWidth(context)) ? 250 : 300,
                                height: (isScreenWidth(context)) ? 250 : 300,
                                child: selectScreen == 0
                                    ? makeQrCodeController(
                                        valueQr: scanQrCodeListController
                                            .scanQrCodeList[qrIndex!],
                                      )
                                    : Text(
                                        scanQrCodeListController
                                            .scanQrCodeList[qrIndex!],
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
                            final String url = scanQrCodeListController
                                .scanQrCodeList[qrIndex!];
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            } else {
                              throw 'Could not launch ${widget.valueQr}';
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
                  title: Text(
                    AppLocalizations.of(context)!.qr_code,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  iconTheme: IconThemeData(
                    size: 28,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                bottomNavigationBar: GetBuilder<VibrationController>(
                  init: VibrationController(),
                  builder: (VibrationController vibrationController) =>
                      GetBuilder<ScanQrCodeListController>(
                    init: ScanQrCodeListController(),
                    builder:
                        (ScanQrCodeListController scanQrCodeListController) =>
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
                                qrIndex = scanQrCodeListController
                                        .scanQrCodeList.length -
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
                                    //   scanQrCodeListController
                                    //       .scanQrCodeList[qrIndex!],
                                    // );
                                    scanQrCodeListController
                                        .deleteItemFromScanQrCodeList(qrIndex!);
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
                                  scanQrCodeListController
                                          .scanQrCodeList.length -
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
                      child: GetBuilder<ScanQrCodeListController>(
                        init: ScanQrCodeListController(),
                        builder: (ScanQrCodeListController
                                scanQrCodeListController) =>
                            InkWell(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: 300,
                                height: 300,
                                child: selectScreen == 0
                                    ? makeQrCodeController(
                                        valueQr: scanQrCodeListController
                                            .scanQrCodeList[qrIndex!],
                                      )
                                    : Text(
                                        scanQrCodeListController
                                            .scanQrCodeList[qrIndex!],
                                        style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            final String url = scanQrCodeListController
                                .scanQrCodeList[qrIndex!];
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            } else {
                              throw 'Could not launch ${widget.valueQr}';
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

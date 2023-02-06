import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/background_controller.dart';
import 'package:qr_maker_app/controller/make_qr_code_controller.dart';
import 'package:qr_maker_app/view/qr/favorite/show_scan_favorite_qr_code.dart';
import 'package:qr_maker_app/view/qr/favorite/show_make_favorite_qr_code.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:qr_maker_app/controller/favorite/make_qr_code_list_controller.dart';
import 'package:qr_maker_app/controller/favorite/scan_qr_code_list_controller.dart';

class MainFavoriteQr extends StatefulWidget {
  const MainFavoriteQr({Key? key}) : super(key: key);

  @override
  State<MainFavoriteQr> createState() => _MainFavoriteQrState();
}

class _MainFavoriteQrState extends State<MainFavoriteQr> {
  int selectScreen = 1;

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
                          icon: Icons.qr_code_scanner,
                          title: AppLocalizations.of(context)!.scan,
                        ),
                        FloatingNavbarItem(
                          icon: Icons.qr_code,
                          title: AppLocalizations.of(context)!.make,
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
                    Padding(
                      padding: EdgeInsets.only(
                        top: isScreenWidth(context) ? 65 : 75,
                        left: 10,
                        right: 10,
                      ),
                      child: (selectScreen == 1)
                          ? GetBuilder<MakeQrCodeListController>(
                              init: MakeQrCodeListController(),
                              builder: (MakeQrCodeListController controller) =>
                                  GridView.builder(
                                itemCount: controller.makeQrCodeList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (isScreenWidth(context)) ? 3 : 5,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => ShowMakeFavoriteQrCode(
                                            index: index,
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.memory(
                                          Uint8List.fromList(controller
                                              .makeQrCodeList[index].codeUnits),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : GetBuilder<ScanQrCodeListController>(
                              init: ScanQrCodeListController(),
                              builder: (ScanQrCodeListController
                                      scanQrCodeListController) =>
                                  GridView.builder(
                                itemCount: scanQrCodeListController
                                    .scanQrCodeList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (isScreenWidth(context)) ? 3 : 5,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => ShowScanFavoriteQrCode(
                                            index: index,
                                            length: scanQrCodeListController
                                                .scanQrCodeList.length,
                                            valueQr: scanQrCodeListController
                                                .scanQrCodeList[index],
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: makeQrCodeController(
                                          valueQr: scanQrCodeListController
                                              .scanQrCodeList[index],
                                        ),
                                      ),
                                    ),
                                  );
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
              child: Stack(
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
                        icon: Icons.qr_code_scanner,
                        title: AppLocalizations.of(context)!.scan,
                      ),
                      FloatingNavbarItem(
                        icon: Icons.qr_code,
                        title: AppLocalizations.of(context)!.make,
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
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 75,
                      left: 10,
                      right: 10,
                    ),
                    child: (selectScreen == 1)
                        ? GetBuilder<MakeQrCodeListController>(
                            init: MakeQrCodeListController(),
                            builder: (MakeQrCodeListController controller) =>
                                GridView.builder(
                              itemCount: controller.makeQrCodeList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => ShowMakeFavoriteQrCode(
                                          index: index,
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.memory(
                                        Uint8List.fromList(controller
                                            .makeQrCodeList[index].codeUnits),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : GetBuilder<ScanQrCodeListController>(
                            init: ScanQrCodeListController(),
                            builder: (ScanQrCodeListController
                                    scanQrCodeListController) =>
                                GridView.builder(
                              itemCount: scanQrCodeListController
                                  .scanQrCodeList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => ShowScanFavoriteQrCode(
                                          index: index,
                                          length: scanQrCodeListController
                                              .scanQrCodeList.length,
                                          valueQr: scanQrCodeListController
                                              .scanQrCodeList[index],
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: makeQrCodeController(
                                        valueQr: scanQrCodeListController
                                            .scanQrCodeList[index],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
  }
}

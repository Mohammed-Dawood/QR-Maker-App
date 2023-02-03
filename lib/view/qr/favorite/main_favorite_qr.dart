import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_maker_app/controller/backround_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/favorite/make_qr_code_list_controller.dart';
import 'package:qr_maker_app/view/qr/favorite/show_favorite_qr_image.dart';

class MainFavoriteQr extends StatefulWidget {
  const MainFavoriteQr({Key? key}) : super(key: key);

  @override
  State<MainFavoriteQr> createState() => _MainFavoriteQrState();
}

class _MainFavoriteQrState extends State<MainFavoriteQr> {
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
                body: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: GetBuilder<MakeQrCodeListController>(
                    init: MakeQrCodeListController(),
                    builder: (MakeQrCodeListController controller) =>
                        GridView.builder(
                      itemCount: controller.makeQrCodeList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (isScreenWidth(context)) ? 3 : 5,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => ShowFavoriteQrImage(
                                  index: index,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.memory(
                                Uint8List.fromList(
                                    controller.makeQrCodeList[index].codeUnits),
                              ),
                            ),
                          ),
                        );
                      },
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
              decoration: backgroundController(controller),
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: GetBuilder<MakeQrCodeListController>(
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
                                () => ShowFavoriteQrImage(
                                  index: index,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.memory(
                                Uint8List.fromList(
                                    controller.makeQrCodeList[index].codeUnits),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

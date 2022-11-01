import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/favorite_qr_code_controller.dart';
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
                body: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: GetBuilder<FavoriteQrCodeController>(
                    init: FavoriteQrCodeController(),
                    builder: (FavoriteQrCodeController controller) =>
                        GridView.builder(
                      itemCount: controller.favoriteQrCodeImageList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (isScreenWidth(context)) ? 3 : 5,
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
                                Uint8List.fromList(controller
                                    .favoriteQrCodeImageList[index].codeUnits),
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
                body: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: GetBuilder<FavoriteQrCodeController>(
                    init: FavoriteQrCodeController(),
                    builder: (FavoriteQrCodeController controller) =>
                        GridView.builder(
                      itemCount: controller.favoriteQrCodeImageList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
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
                                Uint8List.fromList(controller
                                    .favoriteQrCodeImageList[index].codeUnits),
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

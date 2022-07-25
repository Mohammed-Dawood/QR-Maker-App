import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/History/show_qr_image.dart';
import 'package:qr_maker_app/controller/history_qr_code_controller.dart';

class MainQrHistory extends StatefulWidget {
  const MainQrHistory({Key? key}) : super(key: key);

  @override
  State<MainQrHistory> createState() => _MainQrHistoryState();
}

class _MainQrHistoryState extends State<MainQrHistory> {
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
                  child: GetBuilder<HistoryQrCodeController>(
                    init: HistoryQrCodeController(),
                    builder: (HistoryQrCodeController controller) =>
                        GridView.builder(
                      itemCount: controller.historyQrCodeImageList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (isScreenWidth(context)) ? 3 : 5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => ShowQrImage(
                                  image:
                                      controller.historyQrCodeImageList[index],
                                  index: index,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                controller.historyQrCodeImageList[index],
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
                  child: GetBuilder<HistoryQrCodeController>(
                    init: HistoryQrCodeController(),
                    builder: (HistoryQrCodeController controller) =>
                        GridView.builder(
                      itemCount: controller.historyQrCodeImageList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => ShowQrImage(
                                  image:
                                      controller.historyQrCodeImageList[index],
                                  index: index,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                controller.historyQrCodeImageList[index],
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

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/save_qr_code_controller.dart';
import 'package:qr_maker_app/controller/share_qr_code_controller.dart';
import 'package:qr_maker_app/controller/history_qr_code_controller.dart';

class ShowQrImage extends StatefulWidget {
  const ShowQrImage({
    Key? key,
    required this.index,
    required this.image,
  }) : super(key: key);

  final int index;
  final String image;

  @override
  State<ShowQrImage> createState() => _ShowQrImageState();
}

class _ShowQrImageState extends State<ShowQrImage> {
  HistoryQrCodeController historyQrCodeController = Get.find();

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
                    'Show QR Image',
                    style: TextStyle(
                      fontSize: (isScreenWidth(context)) ? 20 : 28,
                    ),
                  ),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: SizedBox(
                          height: (isScreenWidth(context)) ? 300 : 400,
                          width: (isScreenWidth(context)) ? 300 : 400,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Screenshot(
                              controller: screenshotController,
                              child: Image.asset(
                                widget.image,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<SaveQrCodeController>(
                        init: SaveQrCodeController(),
                        builder: (SaveQrCodeController controller) => Card(
                          child: SizedBox(
                            width: (isScreenWidth(context)) ? 300 : 400,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final image =
                                    await screenshotController.capture();
                                controller.saveQrCode(image!);
                              },
                              icon: Icon(
                                Icons.save,
                                size: (isScreenWidth(context)) ? 30 : 35,
                              ),
                              label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                child: Text(
                                  ' Save QR Code',
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.headline3
                                      : Theme.of(context).textTheme.headline2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<ShareQrCodeController>(
                        init: ShareQrCodeController(),
                        builder: (ShareQrCodeController controller) => Card(
                          child: SizedBox(
                            width: (isScreenWidth(context)) ? 300 : 400,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final image =
                                    await screenshotController.capture();
                                controller.shareQrCode(image!);
                              },
                              icon: Icon(
                                Icons.share,
                                size: (isScreenWidth(context)) ? 30 : 35,
                              ),
                              label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                child: Text(
                                  'Share QR Code',
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.headline3
                                      : Theme.of(context).textTheme.headline2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: SizedBox(
                          width: (isScreenWidth(context)) ? 300 : 400,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              historyQrCodeController
                                  .deleteItemFromQrCodeImageList(widget.index);
                            },
                            icon: Icon(
                              Icons.delete,
                              size: (isScreenWidth(context)) ? 30 : 35,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              child: Text(
                                'Delete QR Code',
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.headline3
                                    : Theme.of(context).textTheme.headline2,
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
                    'Show QR Image',
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: SizedBox(
                          height: 400,
                          width: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Screenshot(
                              controller: screenshotController,
                              child: Image.asset(
                                widget.image,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<SaveQrCodeController>(
                        init: SaveQrCodeController(),
                        builder: (SaveQrCodeController controller) => Card(
                          child: SizedBox(
                            width: 400,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final image =
                                    await screenshotController.capture();
                                controller.saveQrCode(image!);
                              },
                              icon: const Icon(
                                Icons.save,
                                size: 35,
                              ),
                              label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                child: Text(
                                  ' Save QR Code',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<ShareQrCodeController>(
                        init: ShareQrCodeController(),
                        builder: (ShareQrCodeController controller) => Card(
                          child: SizedBox(
                            width: 400,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final image =
                                    await screenshotController.capture();
                                controller.shareQrCode(image!);
                              },
                              icon: const Icon(
                                Icons.share,
                                size: 35,
                              ),
                              label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                child: Text(
                                  'Share QR Code',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: SizedBox(
                          width: 400,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              historyQrCodeController
                                  .deleteItemFromQrCodeImageList(widget.index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 35,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              child: Text(
                                'Delete QR Code',
                                style: Theme.of(context).textTheme.headline2,
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

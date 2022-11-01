import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/vibration_controller.dart';
import 'package:qr_maker_app/controller/save_qr_code_controller.dart';
import 'package:qr_maker_app/controller/share_qr_code_controller.dart';
import 'package:qr_maker_app/controller/favorite_qr_code_controller.dart';

class ShowFavoriteQrImage extends StatefulWidget {
  const ShowFavoriteQrImage({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<ShowFavoriteQrImage> createState() => _ShowFavoriteQrImageState();
}

class _ShowFavoriteQrImageState extends State<ShowFavoriteQrImage> {
  int? qrIndex;
  FavoriteQrCodeController favoriteQrCodeController = Get.find();
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
                  title: GetBuilder<FavoriteQrCodeController>(
                    init: FavoriteQrCodeController(),
                    builder: (FavoriteQrCodeController controller) => Text(
                      GetStorage().read(
                            controller.favoriteQrCodeImageList[qrIndex!],
                          ) ??
                          'Change QR Code Name',
                      style: TextStyle(
                        fontSize: (isScreenWidth(context)) ? 20 : 28,
                      ),
                    ),
                  ),
                  actions: [
                    GetBuilder<FavoriteQrCodeController>(
                      init: FavoriteQrCodeController(),
                      builder: (FavoriteQrCodeController controller) =>
                          IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                'Write QR Code Name',
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
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'QR Code Name',
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(
                                      Icons.qr_code,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    suffixIcon: textEditingController
                                            .text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                textEditingController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                    border: const OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 3,
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
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      GetStorage().write(
                                        controller
                                            .favoriteQrCodeImageList[qrIndex!],
                                        textEditingController.text,
                                      );
                                    });
                                    Get.back();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: isScreenWidth(context) ? 20 : 60,
                          ),
                          child: Card(
                            child: SizedBox(
                              height: (isScreenWidth(context)) ? 250 : 410,
                              width: (isScreenWidth(context)) ? 250 : 410,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Screenshot(
                                  controller: screenshotController,
                                  child: GetBuilder<FavoriteQrCodeController>(
                                    init: FavoriteQrCodeController(),
                                    builder:
                                        (FavoriteQrCodeController controller) =>
                                            Image.memory(
                                      Uint8List.fromList(
                                        controller
                                            .favoriteQrCodeImageList[qrIndex!]
                                            .codeUnits,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.transparent,
                          shadowColor: Colors.transparent,
                          child: SizedBox(
                            width: (isScreenWidth(context)) ? 250 : 410,
                            child: Row(
                              children: [
                                GetBuilder<FavoriteQrCodeController>(
                                  init: FavoriteQrCodeController(),
                                  builder:
                                      (FavoriteQrCodeController controller) =>
                                          Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          if (qrIndex! > 0) {
                                            qrIndex = qrIndex! - 1;
                                          } else {
                                            qrIndex = controller
                                                    .favoriteQrCodeImageList
                                                    .length -
                                                1;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size:
                                            (isScreenWidth(context)) ? 30 : 35,
                                      ),
                                      label: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 18),
                                        child: Text(
                                          'prev',
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
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GetBuilder<FavoriteQrCodeController>(
                                  init: FavoriteQrCodeController(),
                                  builder:
                                      (FavoriteQrCodeController controller) =>
                                          Expanded(
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            if ((qrIndex!) <
                                                controller
                                                        .favoriteQrCodeImageList
                                                        .length -
                                                    1) {
                                              qrIndex = qrIndex! + 1;
                                            } else {
                                              qrIndex = 0;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          size: (isScreenWidth(context))
                                              ? 30
                                              : 35,
                                        ),
                                        label: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 18),
                                          child: Text(
                                            'Next',
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
                                    ),
                                  ),
                                ),
                              ],
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
                              child: SizedBox(
                                width: (isScreenWidth(context)) ? 250 : 410,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final image =
                                        await screenshotController.capture();
                                    controller.saveQrCode(image!);
                                    vibrationController.vibration();
                                  },
                                  icon: Icon(
                                    Icons.save,
                                    size: (isScreenWidth(context)) ? 30 : 35,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    child: Text(
                                      'Save QR Code',
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
                              child: SizedBox(
                                width: (isScreenWidth(context)) ? 250 : 410,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final image =
                                        await screenshotController.capture();
                                    controller.shareQrCode(image!);
                                    vibrationController.vibration();
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    size: (isScreenWidth(context)) ? 30 : 35,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    child: Text(
                                      'Share QR Code',
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
                              ),
                            ),
                          ),
                        ),
                        GetBuilder<VibrationController>(
                          init: VibrationController(),
                          builder: (VibrationController vibrationController) =>
                              Card(
                            child: SizedBox(
                              width: (isScreenWidth(context)) ? 250 : 410,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text(
                                        'Delete QR Code !',
                                        style: (isScreenWidth(context))
                                            ? Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                            : Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                      ),
                                      content: const Text(
                                        'Are you sure you want to delete your QR Code? This QR Code will be deleted from favorite on your device.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            favoriteQrCodeController
                                                .deleteItemFromQrCodeImageList(
                                              widget.index,
                                            );
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                  vibrationController.vibration();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: (isScreenWidth(context)) ? 30 : 35,
                                ),
                                label: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  child: Text(
                                    'Delete QR Code',
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
                            ),
                          ),
                        ),
                      ],
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
                appBar: AppBar(
                  title: GetBuilder<FavoriteQrCodeController>(
                    init: FavoriteQrCodeController(),
                    builder: (FavoriteQrCodeController controller) => Text(
                      GetStorage().read(
                            controller.favoriteQrCodeImageList[qrIndex!],
                          ) ??
                          'Change QR Code Name',
                      style: const TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
                  actions: [
                    GetBuilder<FavoriteQrCodeController>(
                      init: FavoriteQrCodeController(),
                      builder: (FavoriteQrCodeController controller) =>
                          IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                'Write QR Code Name',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              content: SingleChildScrollView(
                                child: TextFormField(
                                  maxLines: 1,
                                  cursorWidth: 3,
                                  controller: textEditingController,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'QR Code Name',
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(
                                      Icons.qr_code,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    suffixIcon: textEditingController
                                            .text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                textEditingController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                    border: const OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 3,
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
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      GetStorage().write(
                                          controller.favoriteQrCodeImageList[
                                              qrIndex!],
                                          textEditingController.text);
                                    });
                                    Get.back();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: Card(
                            child: SizedBox(
                              height: 410,
                              width: 410,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Screenshot(
                                  controller: screenshotController,
                                  child: GetBuilder<FavoriteQrCodeController>(
                                    init: FavoriteQrCodeController(),
                                    builder:
                                        (FavoriteQrCodeController controller) =>
                                            Image.memory(
                                      Uint8List.fromList(
                                        controller
                                            .favoriteQrCodeImageList[qrIndex!]
                                            .codeUnits,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.transparent,
                          shadowColor: Colors.transparent,
                          child: SizedBox(
                            width: 410,
                            child: Row(
                              children: [
                                GetBuilder<FavoriteQrCodeController>(
                                  init: FavoriteQrCodeController(),
                                  builder:
                                      (FavoriteQrCodeController controller) =>
                                          Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          if (qrIndex! > 0) {
                                            qrIndex = qrIndex! - 1;
                                          } else {
                                            qrIndex = controller
                                                    .favoriteQrCodeImageList
                                                    .length -
                                                1;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size:
                                            (isScreenWidth(context)) ? 30 : 35,
                                      ),
                                      label: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 18),
                                        child: Text(
                                          'Prev',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GetBuilder<FavoriteQrCodeController>(
                                  init: FavoriteQrCodeController(),
                                  builder:
                                      (FavoriteQrCodeController controller) =>
                                          Expanded(
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            if (qrIndex! <
                                                controller
                                                        .favoriteQrCodeImageList
                                                        .length -
                                                    1) {
                                              qrIndex = qrIndex! + 1;
                                            } else {
                                              qrIndex = 0;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          size: (isScreenWidth(context))
                                              ? 30
                                              : 35,
                                        ),
                                        label: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 18),
                                          child: Text(
                                            'Next',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                              child: SizedBox(
                                width: 410,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final image =
                                        await screenshotController.capture();
                                    controller.saveQrCode(image!);
                                    vibrationController.vibration();
                                  },
                                  icon: const Icon(
                                    Icons.save,
                                    size: 35,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    child: Text(
                                      'Save QR Code',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
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
                              child: SizedBox(
                                width: 410,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final image =
                                        await screenshotController.capture();
                                    controller.shareQrCode(image!);
                                    vibrationController.vibration();
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    size: 35,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    child: Text(
                                      'Share QR Code',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GetBuilder<VibrationController>(
                          init: VibrationController(),
                          builder: (VibrationController vibrationController) =>
                              Card(
                            child: SizedBox(
                              width: 410,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text(
                                        'Delete QR Code !',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      content: const Text(
                                        'Are you sure you want to delete your QR Code? This QR Code will be deleted from favorite on your device.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            favoriteQrCodeController
                                                .deleteItemFromQrCodeImageList(
                                              widget.index,
                                            );
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                  vibrationController.vibration();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 35,
                                ),
                                label: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  child: Text(
                                    'Delete QR Code',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
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
            ),
          );
  }
}

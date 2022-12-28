import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                          AppLocalizations.of(context)!.change_qr_code_name,
                      style: TextStyle(
                        fontSize: (isScreenWidth(context)) ? 20 : 28,
                      ),
                    ),
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
                                  prefixIcon: Icon(
                                    Icons.qr_code,
                                    size: (isScreenWidth(context)) ? 24 : 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  suffixIcon: textEditingController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              textEditingController.clear(),
                                          icon: Icon(
                                            Icons.close,
                                            size: (isScreenWidth(context))
                                                ? 24
                                                : 30,
                                            color:
                                                Theme.of(context).primaryColor,
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
                              GetBuilder<FavoriteQrCodeController>(
                                init: FavoriteQrCodeController(),
                                builder:
                                    (FavoriteQrCodeController controller) =>
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
                      icon: const Icon(Icons.edit),
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
                                            (isScreenWidth(context)) ? 24 : 30,
                                      ),
                                      label: Padding(
                                        padding: (isScreenWidth(context))
                                            ? const EdgeInsets.symmetric(
                                                vertical: 18)
                                            : const EdgeInsets.symmetric(
                                                vertical: 20),
                                        child: Text(
                                          AppLocalizations.of(context)!.prev,
                                          style: TextStyle(
                                            fontSize: (isScreenWidth(context))
                                                ? 18
                                                : 26,
                                          ),
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
                                              ? 24
                                              : 30,
                                        ),
                                        label: Padding(
                                          padding: (isScreenWidth(context))
                                              ? const EdgeInsets.symmetric(
                                                  vertical: 18)
                                              : const EdgeInsets.symmetric(
                                                  vertical: 20),
                                          child: Text(
                                            AppLocalizations.of(context)!.next,
                                            style: TextStyle(
                                              fontSize: (isScreenWidth(context))
                                                  ? 18
                                                  : 26,
                                            ),
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
                                    controller.saveQrCode(image!, context);
                                    vibrationController.vibration();
                                  },
                                  icon: Icon(
                                    Icons.save,
                                    size: (isScreenWidth(context)) ? 24 : 30,
                                  ),
                                  label: Padding(
                                    padding: (isScreenWidth(context))
                                        ? const EdgeInsets.symmetric(
                                            vertical: 18)
                                        : const EdgeInsets.symmetric(
                                            vertical: 20),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .save_qr_code,
                                      style: TextStyle(
                                        fontSize:
                                            (isScreenWidth(context)) ? 18 : 26,
                                      ),
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
                                    size: (isScreenWidth(context)) ? 24 : 30,
                                  ),
                                  label: Padding(
                                    padding: (isScreenWidth(context))
                                        ? const EdgeInsets.symmetric(
                                            vertical: 18)
                                        : const EdgeInsets.symmetric(
                                            vertical: 20),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .share_qr_code,
                                      style: TextStyle(
                                        fontSize:
                                            (isScreenWidth(context)) ? 18 : 26,
                                      ),
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
                                        AppLocalizations.of(context)!
                                            .delete_qr_code_text,
                                        style: (isScreenWidth(context))
                                            ? Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                            : Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                      ),
                                      content: Text(
                                        AppLocalizations.of(context)!
                                            .delete_qr_code_message,
                                        style: (isScreenWidth(context))
                                            ? Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                            : Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .cancel,
                                          ),
                                        ),
                                        GetBuilder<FavoriteQrCodeController>(
                                          init: FavoriteQrCodeController(),
                                          builder: (FavoriteQrCodeController
                                                  controller) =>
                                              TextButton(
                                            onPressed: () async {
                                              GetStorage().remove(
                                                controller
                                                        .favoriteQrCodeImageList[
                                                    qrIndex!],
                                              );
                                              controller
                                                  .deleteItemFromQrCodeImageList(
                                                qrIndex!,
                                              );
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .delete,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  vibrationController.vibration();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: (isScreenWidth(context)) ? 24 : 30,
                                ),
                                label: Padding(
                                  padding: (isScreenWidth(context))
                                      ? const EdgeInsets.symmetric(vertical: 18)
                                      : const EdgeInsets.symmetric(
                                          vertical: 20),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .delete_qr_code,
                                    style: TextStyle(
                                      fontSize:
                                          (isScreenWidth(context)) ? 18 : 26,
                                    ),
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
                          AppLocalizations.of(context)!.change_qr_code_name,
                      style: const TextStyle(
                        fontSize: 28,
                      ),
                    ),
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
                                  prefixIcon: Icon(
                                    Icons.qr_code,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  suffixIcon: textEditingController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              textEditingController.clear(),
                                          icon: Icon(
                                            Icons.close,
                                            size: 30,
                                            color:
                                                Theme.of(context).primaryColor,
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
                              GetBuilder<FavoriteQrCodeController>(
                                init: FavoriteQrCodeController(),
                                builder:
                                    (FavoriteQrCodeController controller) =>
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
                      icon: const Icon(Icons.edit),
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
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        size: 30,
                                      ),
                                      label: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.prev,
                                          style: const TextStyle(
                                            fontSize: 26,
                                          ),
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
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          size: 30,
                                        ),
                                        label: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 20,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context)!.next,
                                            style: const TextStyle(
                                              fontSize: 26,
                                            ),
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
                                    controller.saveQrCode(image!, context);
                                    vibrationController.vibration();
                                  },
                                  icon: const Icon(
                                    Icons.save,
                                    size: 30,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .save_qr_code,
                                      style: const TextStyle(
                                        fontSize: 26,
                                      ),
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
                                    size: 30,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .share_qr_code,
                                      style: const TextStyle(
                                        fontSize: 26,
                                      ),
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
                                        AppLocalizations.of(context)!
                                            .delete_qr_code_text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      content: Text(
                                        AppLocalizations.of(context)!
                                            .delete_qr_code_message,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .cancel,
                                          ),
                                        ),
                                        GetBuilder<FavoriteQrCodeController>(
                                          init: FavoriteQrCodeController(),
                                          builder: (FavoriteQrCodeController
                                                  controller) =>
                                              TextButton(
                                            onPressed: () async {
                                              GetStorage().remove(
                                                controller
                                                        .favoriteQrCodeImageList[
                                                    qrIndex!],
                                              );
                                              controller
                                                  .deleteItemFromQrCodeImageList(
                                                qrIndex!,
                                              );
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .delete,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  vibrationController.vibration();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 30,
                                ),
                                label: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .delete_qr_code,
                                    style: const TextStyle(
                                      fontSize: 26,
                                    ),
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

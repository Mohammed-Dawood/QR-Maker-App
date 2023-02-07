import 'dart:async';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MakeQrCodeListController extends GetxController {
  List<String> makeQrCodeList = [];
  List<String> makeQrImageList = [];

  Future<void> addItemToMakeQrCodeList(
    String valueQr,
    Uint8List qrImage,
    BuildContext context,
  ) async {
    String qrCode = valueQr;
    String qrImageToString = String.fromCharCodes(qrImage);

    for (var index = 0; index < makeQrCodeList.length; index++) {
      if (qrCode == makeQrCodeList[index]) {
        Get.snackbar(
          'QR Maker',
          AppLocalizations.of(context)!.already_favorite_snackbar,
          icon: const Icon(
            Icons.done,
            color: Colors.green,
            size: 30,
          ),
          shouldIconPulse: false,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 10,
          ),
        );
        return;
      }
    }

    makeQrCodeList.add(qrCode);
    makeQrImageList.add(qrImageToString);

    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setStringList('new_MakeQrCodeList', makeQrCodeList);
    await pref.setStringList('new_MakeQrImageList', makeQrImageList);

    Get.snackbar(
      'QR Maker',
      AppLocalizations.of(context)!.favorite_snackbar,
      icon: const Icon(
        Icons.done,
        color: Colors.green,
        size: 30,
      ),
      shouldIconPulse: false,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
    );
  }

  Future<void> getMakeQrCodeListFromSharePref() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    makeQrCodeList = pref.getStringList('new_MakeQrCodeList')!;
    makeQrImageList = pref.getStringList('new_MakeQrImageList')!;
    print(makeQrCodeList);
    print(makeQrImageList);
  }

  Future<void> deleteItemFromMakeQrCodeList(int number) async {
    makeQrCodeList.remove(makeQrCodeList[number]);
    makeQrImageList.remove(makeQrImageList[number]);

    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setStringList('new_MakeQrCodeList', makeQrCodeList);
    await pref.setStringList('new_MakeQrImageList', makeQrImageList);

    update();

    Get.back();
    Get.back();
  }
}

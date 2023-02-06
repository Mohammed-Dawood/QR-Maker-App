import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScanQrCodeListController extends GetxController {
  List<String> scanQrCodeList = [];

  Future<void> addItemToScanQrCodeList(
    String valueQr,
    BuildContext context,
  ) async {
    for (var index = 0; index < scanQrCodeList.length; index++) {
      if (valueQr == scanQrCodeList[index]) {
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

    scanQrCodeList.add(valueQr);
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('newScanQrCodeList', scanQrCodeList);

    Get.snackbar(
      'QR Maker',
      AppLocalizations.of(context)!.favorite_snackbar,
      // "The QR Code has been added to favorite successfully",
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

  Future<void> getScanQrCodeListFromSharePref() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    scanQrCodeList = pref.getStringList('newScanQrCodeList')!;
  }

  Future<void> deleteItemFromScanQrCodeList(int number) async {
    scanQrCodeList.remove(scanQrCodeList[number]);
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('newScanQrCodeList', scanQrCodeList);
    update();
    Get.back();
    Get.back();
  }
}

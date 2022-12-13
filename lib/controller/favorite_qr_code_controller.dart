import 'dart:async';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteQrCodeController extends GetxController {
  List<String> favoriteQrCodeImageList = [];

  Future<void> addQrCodeImageToFavorite(
    Uint8List qrImage,
  ) async {
    String qrCodeImageString = String.fromCharCodes(qrImage);

    for (var index = 0; index < favoriteQrCodeImageList.length; index++) {
      if (qrCodeImageString == favoriteQrCodeImageList[index]) {
        Get.snackbar(
          'QR Maker',
          "You already have this QR Code in favorite",
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
    favoriteQrCodeImageList.add(qrCodeImageString);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('newQrCodeImageList', favoriteQrCodeImageList);

    Get.snackbar(
      'QR Maker',
      "The QR Code has been added to favorite successfully",
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

  Future<void> getQrImageListFromSharePref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    favoriteQrCodeImageList = prefs.getStringList('newQrCodeImageList')!;
  }

  Future<void> deleteItemFromQrCodeImageList(int number) async {
    favoriteQrCodeImageList.remove(favoriteQrCodeImageList[number]);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('newQrCodeImageList', favoriteQrCodeImageList);
    update();
    Get.back();
    Get.back();
  }
}

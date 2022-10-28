import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteQrCodeController extends GetxController {
  List<String> favoriteQrCodeImageList = [];

  Future<void> addQrCodeImageToFavorite(
    Uint8List qrImage,
  ) async {
    final Directory directoryQrCodeImage =
        await getApplicationDocumentsDirectory();

    final String pathQrCodeImage = directoryQrCodeImage.path;

    final String time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');

    String nameQrCodeImage = 'QRMakerApp_$time.txt';

    var fileQr = File('$pathQrCodeImage/$nameQrCodeImage');

    fileQr.writeAsBytes(
      qrImage.buffer.asInt8List(
        qrImage.offsetInBytes,
        qrImage.lengthInBytes,
      ),
    );

    favoriteQrCodeImageList.add('$pathQrCodeImage/$nameQrCodeImage');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('newQrCodeImageList', favoriteQrCodeImageList);

    Get.snackbar(
      'QR Maker',
      "The image has been added to favorite successfully",
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

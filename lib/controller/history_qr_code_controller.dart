import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryQrCodeController extends GetxController {
  List<String> historyQrCodeImageList = [];

  Future<void> addQrCodeImageToHistory(
    Uint8List qrImage,
  ) async {
    final Directory directoryQrCodeImage =
        await getApplicationDocumentsDirectory();

    final String pathQrCodeImage = directoryQrCodeImage.path;

    final String time = DateTime.now().toIso8601String().replaceAll('.', '-');

    String nameQrCodeImage = 'QRMakerApp_$time.txt';

    var fileQr = File('$pathQrCodeImage/$nameQrCodeImage');

    fileQr.writeAsBytes(
      qrImage.buffer.asInt8List(
        qrImage.offsetInBytes,
        qrImage.lengthInBytes,
      ),
    );

    historyQrCodeImageList.add('$pathQrCodeImage/$nameQrCodeImage');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('newQrCodeImageList', historyQrCodeImageList);

    Get.snackbar(
      'QR Maker',
      "The image has been added to history successfully",
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

  Future<void> getQrImageListFromSahrePref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    historyQrCodeImageList = prefs.getStringList('newQrCodeImageList')!;
  }

  Future<void> deleteItemFromQrCodeImageList(int number) async {
    historyQrCodeImageList.remove(historyQrCodeImageList[number]);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('newQrCodeImageList', historyQrCodeImageList);
    update();
    Get.back();
  }
}

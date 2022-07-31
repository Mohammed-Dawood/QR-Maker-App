import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SaveQrCodeController extends GetxController {
  Future<void> saveQrCode(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');

    final name = 'QR Maker_$time';
    await ImageGallerySaver.saveImage(bytes, name: name);
    Get.snackbar(
      'QR Maker',
      "The image has been saved successfully",
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
}

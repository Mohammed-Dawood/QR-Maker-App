import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class ShareQrCodeController extends GetxController {
  Future shareQrCode(Uint8List image) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/image.jpg';
    File(path).writeAsBytesSync(image);

    await Share.shareXFiles(
      [XFile(path)],
      text: 'QR Maker App',
      subject: 'QR Maker App',
    );
  }
}

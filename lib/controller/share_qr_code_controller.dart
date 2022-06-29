import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class ShareQrCodeController extends GetxController {
  Future shareQrCode(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles(
      [image.path],
      text: 'QR Code',
      subject: 'QR Code',
    );
  }
}

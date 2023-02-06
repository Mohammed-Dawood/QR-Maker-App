import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

QrImage makeQrCodeController({
  required String valueQr,
}) {
  return QrImage(
    size: double.infinity,
    gapless: true,
    data: valueQr,
    version: QrVersions.auto,
    semanticsLabel: 'qr maker',
    backgroundColor: Colors.white,
    constrainErrorBounds: true,
    // embeddedImageEmitsError: false,
    errorCorrectionLevel: QrErrorCorrectLevel.L,
    eyeStyle: const QrEyeStyle(
      eyeShape: QrEyeShape.square,
      color: Colors.black,
    ),
    dataModuleStyle: const QrDataModuleStyle(
      dataModuleShape: QrDataModuleShape.square,
      color: Colors.black,
    ),
    // embeddedImage: logoSwitch
    //     ? AssetImage(widget.image)
    //     : null,
    // embeddedImageStyle: QrEmbeddedImageStyle(
    //   size: const Size(50, 50),
    // ),
    errorStateBuilder: (cxt, err) {
      return const Center(
        child: Text(
          "Uh oh! Something went wrong...",
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}

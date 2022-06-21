import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ScanningQRByCamera extends StatefulWidget {
  const ScanningQRByCamera({Key? key}) : super(key: key);

  @override
  State<ScanningQRByCamera> createState() => _ScanningQRByCameraState();
}

class _ScanningQRByCameraState extends State<ScanningQRByCamera> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'Scanner',
                style: TextStyle(fontSize: (isScreenWidth(context)) ? 20 : 28),
              ),
              iconTheme: IconThemeData(
                size: (isScreenWidth(context)) ? 24 : 30,
                color: Colors.white,
              ),
              actions: [
                IconButton(
                  icon: FutureBuilder<bool?>(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return Icon(
                          snapshot.data! ? Icons.flash_off : Icons.flash_on,
                        );
                      } else {
                        return const Icon(Icons.flash_on);
                      }
                    },
                  ),
                  onPressed: () async {
                    await controller?.toggleFlash();
                    setState(
                      () {},
                    );
                  },
                ),
                IconButton(
                  icon: FutureBuilder(
                      future: controller?.getCameraInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return const Icon(
                            Icons.cameraswitch,
                          );
                        } else {
                          return Container();
                        }
                      }),
                  onPressed: () async {
                    await controller?.flipCamera();
                    setState(() {});
                  },
                ),
              ],
            ),
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildQrView(context),
                Positioned(
                  bottom: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      final String url = '${result!.code}';
                      // final String url = 'SMSTO:001234567890:hello';

                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      } else {
                        throw 'Could not launch ${result!.code}';
                      }
                    },
                    child: Padding(
                      padding: (isScreenWidth(context))
                          ? const EdgeInsets.symmetric(vertical: 18)
                          : const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        result != null ? ' Go to link ' : 'Scan QR Code',
                        style: TextStyle(
                            fontSize: (isScreenWidth(context)) ? 18 : 25),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Scanner',
                style: TextStyle(fontSize: 28),
              ),
              iconTheme: const IconThemeData(
                size: 30,
                color: Colors.white,
              ),
              actions: [
                IconButton(
                  icon: FutureBuilder<bool?>(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return Icon(
                          snapshot.data! ? Icons.flash_off : Icons.flash_on,
                        );
                      } else {
                        return const Icon(Icons.flash_on);
                      }
                    },
                  ),
                  onPressed: () async {
                    await controller?.toggleFlash();
                    setState(
                      () {},
                    );
                  },
                ),
                IconButton(
                  icon: FutureBuilder(
                      future: controller?.getCameraInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return const Icon(
                            Icons.cameraswitch,
                          );
                        } else {
                          return Container();
                        }
                      }),
                  onPressed: () async {
                    await controller?.flipCamera();
                    setState(() {});
                  },
                ),
              ],
            ),
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildQrView(context),
                Positioned(
                  bottom: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      final String url = '${result!.code}';
                      // final String url = 'SMSTO:001234567890:hello';

                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      } else {
                        throw 'Could not launch ${result!.code}';
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        result != null ? ' Go to link ' : 'Scan QR Code',
                        style: const TextStyle(fontSize: 25),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 350.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((Barcode scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}






//  Positioned(
//             bottom: 50,
//             child: ElevatedButton(
//               onPressed: () async {
//                 if (await canLaunch('${result!.code}')) {
//                   await launch(
//                     '${result!.code}',
//                     forceSafariVC: true,
//                     forceWebView: true,
//                     enableJavaScript: true,
//                   );
//                 } else {
//                   throw 'Problem launching ${result!.code}';
//                 }
//               },
//               child: Text(
//                 result != null ? 'Result : ${result!.code}' : 'Scan QR Code',
//                 maxLines: 1,
//               ),
//             ),
//           ),


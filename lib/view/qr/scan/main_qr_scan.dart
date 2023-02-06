import 'dart:io';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/vibration_controller.dart';
import 'package:qr_maker_app/controller/favorite/scan_qr_code_list_controller.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class MainQrScan extends StatefulWidget {
  const MainQrScan({Key? key}) : super(key: key);

  @override
  State<MainQrScan> createState() => _MainQrScanState();
}

class _MainQrScanState extends State<MainQrScan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  ScanQrCodeListController favoriteScanQrCodeController = Get.find();
  VibrationController vibrationController = Get.put(VibrationController());

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
            body: Stack(
              children: [
                _buildQrView(context),
                FloatingNavbar(
                  currentIndex: 0,
                  borderRadius: 0,
                  itemBorderRadius: 5,
                  selectedItemColor:
                      result != null ? Colors.white : Colors.white30,
                  unselectedItemColor:
                      result != null ? Colors.white : Colors.white30,
                  iconSize: isScreenWidth(context) ? 24 : 28,
                  fontSize: isScreenWidth(context) ? 12 : 14,
                  backgroundColor: Theme.of(context).primaryColor,
                  selectedBackgroundColor: Theme.of(context).primaryColor,
                  margin: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 0,
                  ),
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  items: [
                    FloatingNavbarItem(
                      icon: Icons.open_in_browser,
                      title: AppLocalizations.of(context)!.open_the_link,
                    ),
                    FloatingNavbarItem(
                      icon: Icons.add_box,
                      title: AppLocalizations.of(context)!.favorite,
                    ),
                    FloatingNavbarItem(
                      customWidget: InkWell(
                        child: Column(
                          children: [
                            FutureBuilder<bool?>(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Icon(
                                    snapshot.data!
                                        ? Icons.flash_on
                                        : Icons.flash_off,
                                    size: isScreenWidth(context) ? 22 : 26,
                                    color: snapshot.data!
                                        ? Colors.amber
                                        : Colors.white,
                                  );
                                } else {
                                  return const Icon(Icons.flash_off);
                                }
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.flash,
                              style: TextStyle(
                                fontSize: isScreenWidth(context) ? 12 : 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  onTap: (int screenNumber) async {
                    if (screenNumber == 0) {
                      final String url = '${result!.code}';
                      // final String url = 'SMSTO:001234567890:hello';
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      } else {
                        throw 'Could not launch ${result!.code}';
                      }
                    }
                    if (screenNumber == 1) {
                      final String valueQr = '${result!.code}';
                      favoriteScanQrCodeController.addItemToScanQrCodeList(
                        valueQr,
                        context,
                      );
                    }
                    if (screenNumber == 2) {
                      await controller?.toggleFlash();
                      setState(
                        () {},
                      );
                    }
                  },
                ),
              ],
            ),
          )
        : Scaffold(
            body: Stack(
              children: [
                _buildQrView(context),
                FloatingNavbar(
                  currentIndex: 0,
                  borderRadius: 0,
                  itemBorderRadius: 5,
                  selectedItemColor:
                      result != null ? Colors.white : Colors.white30,
                  unselectedItemColor:
                      result != null ? Colors.white : Colors.white30,
                  iconSize: 28,
                  fontSize: 14,
                  backgroundColor: Theme.of(context).primaryColor,
                  selectedBackgroundColor: Theme.of(context).primaryColor,
                  margin: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 0,
                  ),
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  items: [
                    FloatingNavbarItem(
                      icon: Icons.open_in_browser,
                      title: AppLocalizations.of(context)!.open_the_link,
                    ),
                    FloatingNavbarItem(
                      icon: Icons.add_box,
                      title: AppLocalizations.of(context)!.favorite,
                    ),
                    FloatingNavbarItem(
                      customWidget: InkWell(
                        child: Column(
                          children: [
                            FutureBuilder<bool?>(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Icon(
                                    snapshot.data!
                                        ? Icons.flash_on
                                        : Icons.flash_off,
                                    size: 26,
                                    color: snapshot.data!
                                        ? Colors.amber
                                        : Colors.white,
                                  );
                                } else {
                                  return const Icon(Icons.flash_off);
                                }
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.flash,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  onTap: (int screenNumber) async {
                    if (screenNumber == 0) {
                      final String url = '${result!.code}';
                      // final String url = 'SMSTO:001234567890:hello';
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      } else {
                        throw 'Could not launch ${result!.code}';
                      }
                    }
                    if (screenNumber == 1) {
                      final String valueQr = '${result!.code}';
                      favoriteScanQrCodeController.addItemToScanQrCodeList(
                        valueQr,
                        context,
                      );
                    }
                    if (screenNumber == 2) {
                      await controller?.toggleFlash();
                      setState(
                        () {},
                      );
                    }
                  },
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
        vibrationController.vibration();
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


import 'dart:io';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:qr_maker_app/controller/icons_controller.dart';
// import 'package:qr_maker_app/controller/labels_controller.dart';
import 'package:qr_maker_app/controller/vibration_controller.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

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

  VibrationController vibrationController = Get.put(
    VibrationController(),
  );

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
            extendBody: true,
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.scanner,
                style: TextStyle(
                  fontSize: (isScreenWidth(context)) ? 18 : 24,
                ),
              ),
              iconTheme: IconThemeData(
                size: (isScreenWidth(context)) ? 22 : 26,
                color: Theme.of(context).iconTheme.color,
              ),
              // actions: [
              //   IconButton(
              //     icon: FutureBuilder<bool?>(
              //       future: controller?.getFlashStatus(),
              //       builder: (context, snapshot) {
              //         if (snapshot.data != null) {
              //           return Icon(
              //             snapshot.data! ? Icons.flash_off : Icons.flash_on,
              //           );
              //         } else {
              //           return const Icon(Icons.flash_on);
              //         }
              //       },
              //     ),
              //     onPressed: () async {
              //       await controller?.toggleFlash();
              //       setState(
              //         () {},
              //       );
              //     },
              //   ),
              //   IconButton(
              //     icon: FutureBuilder(
              //         future: controller?.getCameraInfo(),
              //         builder: (context, snapshot) {
              //           if (snapshot.data != null) {
              //             return const Icon(
              //               Icons.cameraswitch,
              //             );
              //           } else {
              //             return Container();
              //           }
              //         }),
              //     onPressed: () async {
              //       await controller?.flipCamera();
              //       setState(() {});
              //     },
              //   ),
              // ],
            ),
            bottomNavigationBar: FloatingNavbar(
              currentIndex: 0,
              borderRadius: 5,
              itemBorderRadius: 5,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              selectedBackgroundColor:
                  result != null ? Colors.red : Theme.of(context).primaryColor,
              margin: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 15,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 5,
              ),
              items: [
                FloatingNavbarItem(
                  customWidget: InkWell(
                    child: Column(
                      children: [
                        Icon(
                          result != null ? Icons.open_in_browser : null,
                          size: isScreenWidth(context) ? 24 : 28,
                          color: Colors.white,
                        ),
                        Text(
                          result != null
                              ? AppLocalizations.of(context)!.open_the_link
                              : '',
                          style: TextStyle(
                            fontSize: isScreenWidth(context) ? 12 : 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      final String url = '${result!.code}';
                      // final String url = 'SMSTO:001234567890:hello';
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      } else {
                        throw 'Could not launch ${result!.code}';
                      }
                    },
                  ),
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
                                size: isScreenWidth(context) ? 24 : 28,
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
                          "Flash",
                          style: TextStyle(
                            fontSize: isScreenWidth(context) ? 12 : 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      await controller?.toggleFlash();
                      setState(
                        () {},
                      );
                    },
                  ),
                ),
              ],
              onTap: (int screenNumber) async {
                final String url = '${result!.code}';
                // final String url = 'SMSTO:001234567890:hello';
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  throw 'Could not launch ${result!.code}';
                }
              },
            ),
            body: _buildQrView(context),
            //  Stack(
            //   alignment: Alignment.center,
            //   children: <Widget>[
            //     Positioned(
            //       bottom: 150,
            //       child: Directionality(
            //         textDirection: TextDirection.rtl,
            //         child: ElevatedButton.icon(
            //           style: ButtonStyle(
            //             backgroundColor: result != null
            //                 ? MaterialStateProperty.all(Colors.red)
            //                 : null,
            //           ),
            //           onPressed: () async {
            //             final String url = '${result!.code}';
            //             // final String url = 'SMSTO:001234567890:hello';

            //             if (await canLaunchUrlString(url)) {
            //               await launchUrlString(url);
            //             } else {
            //               throw 'Could not launch ${result!.code}';
            //             }
            //           },
            //           icon: result != null
            //               ? iconController(
            //                   context,
            //                   icon: Icons.arrow_back,
            //                 )
            //               : iconController(
            //                   context,
            //                   icon: Icons.search,
            //                 ),
            //           label: result != null
            //               ? labelController(
            //                   context,
            //                   label: AppLocalizations.of(context)!.go_to_link,
            //                 )
            //               : labelController(
            //                   context,
            //                   label: AppLocalizations.of(context)!.scan_qr_code,
            //                 ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          )
        : Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.scanner,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              iconTheme: IconThemeData(
                size: 26,
                color: Theme.of(context).iconTheme.color,
              ),
              // actions: [
              //   IconButton(
              //     icon: FutureBuilder<bool?>(
              //       future: controller?.getFlashStatus(),
              //       builder: (context, snapshot) {
              //         if (snapshot.data != null) {
              //           return Icon(
              //             snapshot.data! ? Icons.flash_off : Icons.flash_on,
              //           );
              //         } else {
              //           return const Icon(Icons.flash_on);
              //         }
              //       },
              //     ),
              //     onPressed: () async {
              //       await controller?.toggleFlash();
              //       setState(
              //         () {},
              //       );
              //     },
              //   ),
              //   IconButton(
              //     icon: FutureBuilder(
              //         future: controller?.getCameraInfo(),
              //         builder: (context, snapshot) {
              //           if (snapshot.data != null) {
              //             return const Icon(
              //               Icons.cameraswitch,
              //             );
              //           } else {
              //             return Container();
              //           }
              //         }),
              //     onPressed: () async {
              //       await controller?.flipCamera();
              //       setState(() {});
              //     },
              //   ),
              // ],
            ),
            bottomNavigationBar: FloatingNavbar(
              currentIndex: 0,
              borderRadius: 5,
              itemBorderRadius: 5,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              selectedBackgroundColor:
                  result != null ? Colors.red : Theme.of(context).primaryColor,
              margin: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 15,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 5,
              ),
              items: [
                FloatingNavbarItem(
                  customWidget: InkWell(
                    child: Column(
                      children: [
                        Icon(
                          result != null ? Icons.open_in_browser : null,
                          size: 28,
                          color: Colors.white,
                        ),
                        Text(
                          result != null
                              ? AppLocalizations.of(context)!.open_the_link
                              : '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      final String url = '${result!.code}';
                      // final String url = 'SMSTO:001234567890:hello';
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      } else {
                        throw 'Could not launch ${result!.code}';
                      }
                    },
                  ),
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
                                size: 28,
                                color: snapshot.data!
                                    ? Colors.amber
                                    : Colors.white,
                              );
                            } else {
                              return const Icon(Icons.flash_off);
                            }
                          },
                        ),
                        const Text(
                          "Flash",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      await controller?.toggleFlash();
                      setState(
                        () {},
                      );
                    },
                  ),
                ),
              ],
              onTap: (int screenNumber) async {
                final String url = '${result!.code}';
                // final String url = 'SMSTO:001234567890:hello';
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  throw 'Could not launch ${result!.code}';
                }
              },
            ),
            body: _buildQrView(context),
            // Stack(
            //   alignment: Alignment.center,
            //   children: <Widget>[
            //     Positioned(
            //       bottom: 50,
            //       child: Directionality(
            //         textDirection: TextDirection.rtl,
            //         child: ElevatedButton.icon(
            //           style: ButtonStyle(
            //             backgroundColor: result != null
            //                 ? MaterialStateProperty.all(Colors.red)
            //                 : null,
            //           ),
            //           onPressed: () async {
            //             final String url = '${result!.code}';
            //             // final String url = 'SMSTO:001234567890:hello';

            //             if (await canLaunchUrlString(url)) {
            //               await launchUrlString(url);
            //             } else {
            //               throw 'Could not launch ${result!.code}';
            //             }
            //           },
            //           icon: result != null
            //               ? iconController(
            //                   context,
            //                   icon: Icons.arrow_back,
            //                 )
            //               : iconController(
            //                   context,
            //                   icon: Icons.search,
            //                 ),
            //           label: result != null
            //               ? labelController(
            //                   context,
            //                   label: AppLocalizations.of(context)!.go_to_link,
            //                 )
            //               : labelController(
            //                   context,
            //                   label: AppLocalizations.of(context)!.scan_qr_code,
            //                 ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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


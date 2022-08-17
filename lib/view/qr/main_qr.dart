import 'package:get/get.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_maker_app/view/qr/scan/main_qr_scan.dart';
import 'package:qr_maker_app/view/qr/maker/main_qr_make.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/favorite/main_favorite_qr.dart';
import 'package:qr_maker_app/controller/vibration_controller.dart';
import 'package:qr_maker_app/controller/favorite_qr_code_controller.dart';

class MainQr extends StatefulWidget {
  const MainQr({Key? key}) : super(key: key);

  @override
  State<MainQr> createState() => _MainQrState();
}

class _MainQrState extends State<MainQr> {
  int selectScreen = 0;
  List<String> title = [
    'Scan QR Code',
    'Make QR Code',
    'Favorite QR Code',
  ];
  List<Widget> screens = [
    const MainQrScan(),
    const MainQrMake(),
    const MainFavoriteQr(),
  ];

  FavoriteQrCodeController historyQrCodeController = Get.put(
    FavoriteQrCodeController(),
    permanent: true,
  );

  @override
  void initState() {
    historyQrCodeController.getQrImageListFromSahrePref();
    super.initState();
  }

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? GetBuilder<ThemeController>(
            init: ThemeController(),
            builder: (ThemeController themeController) => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: themeController.initValue
                      ? const AssetImage('images/background_dark.png')
                      : const AssetImage('images/background_light.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    title[selectScreen],
                    style: TextStyle(
                      fontSize: (isScreenWidth(context)) ? 20 : 28,
                    ),
                  ),
                  iconTheme: IconThemeData(
                    size: (isScreenWidth(context)) ? 24 : 30,
                    color: Colors.white,
                  ),
                ),
                drawer: Drawer(
                  width: (isScreenWidth(context)) ? 300 : 400,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: themeController.initValue
                            ? const AssetImage('images/background_dark.png')
                            : const AssetImage('images/background_light.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Card(
                        //   child: SizedBox(
                        //     width: double.infinity,
                        //     height: 50,
                        //     child: Center(
                        //       child: Text(
                        //         '${FirebaseAuth.instance.currentUser?.email}',
                        //         overflow: TextOverflow.ellipsis,
                        //         maxLines: 1,
                        //         style: const TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Card(
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: isScreenWidth(context) ? 5 : 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Dark Theme',
                                    style: (isScreenWidth(context))
                                        ? Theme.of(context).textTheme.headline3
                                        : Theme.of(context).textTheme.headline2,
                                  ),
                                  Switch(
                                    value: themeController.initValue,
                                    onChanged: themeController.switchTheme,
                                    activeTrackColor: Colors.white54,
                                    inactiveTrackColor: Colors.grey.shade900,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: isScreenWidth(context) ? 5 : 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Vibration',
                                    style: (isScreenWidth(context))
                                        ? Theme.of(context).textTheme.headline3
                                        : Theme.of(context).textTheme.headline2,
                                  ),
                                  GetBuilder<VibrationController>(
                                    init: VibrationController(),
                                    builder: (VibrationController
                                            vibrationController) =>
                                        Switch(
                                      value: vibrationController.initValue,
                                      onChanged:
                                          vibrationController.switchVibration,
                                      activeTrackColor: Colors.white54,
                                      inactiveTrackColor: Colors.grey.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Card(
                        //   child: SizedBox(
                        //     width: double.infinity,
                        //     height: 50,
                        //     child: ElevatedButton.icon(
                        //       onPressed: () {
                        //         FirebaseAuth.instance.signOut();
                        //       },
                        //       icon: const Icon(Icons.lock_outline),
                        //       label: const Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Text(
                        //           'Sign Out',
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Card(
                        //   child: SizedBox(
                        //     width: double.infinity,
                        //     height: 50,
                        //     child: ElevatedButton.icon(
                        //       onPressed: () {
                        //         showDialog(
                        //           context: context,
                        //           builder: (BuildContext context) => AlertDialog(
                        //             title: Text(
                        //               'Delete QR Maker Account !',
                        //               style: (isScreenWidth(context))
                        //                   ? Theme.of(context).textTheme.headline3
                        //                   : Theme.of(context).textTheme.headline2,
                        //             ),
                        //             content: const Text(
                        //               'Are you sure you want to delete your account? This will permanently erase your account.',
                        //             ),
                        //             actions: [
                        //               TextButton(
                        //                 onPressed: () => Get.back(),
                        //                 child: const Text('Cancel'),
                        //               ),
                        //               TextButton(
                        //                 onPressed: () async {
                        //                   await FirebaseAuth.instance.currentUser
                        //                       ?.delete();
                        //                   Get.back();
                        //                 },
                        //                 child: const Text('Delete'),
                        //               ),
                        //             ],
                        //           ),
                        //         );
                        //       },
                        //       icon: const Icon(Icons.delete),
                        //       label: const Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Text(
                        //           'Delete Account',
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: selectScreen,
                  onTap: (int screenNumber) {
                    setState(
                      () {
                        selectScreen = screenNumber;
                      },
                    );
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.qr_code_scanner,
                      ),
                      label: 'Scan',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.qr_code),
                      label: 'Make',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite,
                      ),
                      label: 'Favorite',
                    ),
                  ],
                ),
                body: screens.elementAt(selectScreen),
              ),
            ),
          )
        : GetBuilder<ThemeController>(
            init: ThemeController(),
            builder: (ThemeController themeController) => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: themeController.initValue
                      ? const AssetImage('images/background_dark.png')
                      : const AssetImage('images/background_light.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    title[selectScreen],
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  iconTheme: const IconThemeData(
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                drawer: Drawer(
                  width: 400,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: themeController.initValue
                            ? const AssetImage('images/background_dark.png')
                            : const AssetImage('images/background_light.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Card(
                        //   child: SizedBox(
                        //     width: double.infinity,
                        //     height: 50,
                        //     child: Center(
                        //       child: Text(
                        //         '${FirebaseAuth.instance.currentUser?.email}',
                        //         overflow: TextOverflow.ellipsis,
                        //         maxLines: 1,
                        //         style: const TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Card(
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Dark Theme',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  Switch(
                                    value: themeController.initValue,
                                    onChanged: themeController.switchTheme,
                                    activeTrackColor: Colors.white54,
                                    inactiveTrackColor: Colors.grey.shade900,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Vibration',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  GetBuilder<VibrationController>(
                                    init: VibrationController(),
                                    builder: (VibrationController
                                            vibrationController) =>
                                        Switch(
                                      value: vibrationController.initValue,
                                      onChanged:
                                          vibrationController.switchVibration,
                                      activeTrackColor: Colors.white54,
                                      inactiveTrackColor: Colors.grey.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Card(
                        //   child: SizedBox(
                        //     width: double.infinity,
                        //     height: 50,
                        //     child: ElevatedButton.icon(
                        //       onPressed: () {
                        //         FirebaseAuth.instance.signOut();
                        //       },
                        //       icon: const Icon(Icons.lock_outline),
                        //       label: const Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Text(
                        //           'Sign Out',
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Card(
                        //   child: SizedBox(
                        //     width: double.infinity,
                        //     height: 50,
                        //     child: ElevatedButton.icon(
                        //       onPressed: () {
                        //         showDialog(
                        //           context: context,
                        //           builder: (BuildContext context) => AlertDialog(
                        //             title: Text(
                        //               'Delete QR Maker Account !',
                        //               style: (isScreenWidth(context))
                        //                   ? Theme.of(context).textTheme.headline3
                        //                   : Theme.of(context).textTheme.headline2,
                        //             ),
                        //             content: const Text(
                        //               'Are you sure you want to delete your account? This will permanently erase your account.',
                        //             ),
                        //             actions: [
                        //               TextButton(
                        //                 onPressed: () => Get.back(),
                        //                 child: const Text('Cancel'),
                        //               ),
                        //               TextButton(
                        //                 onPressed: () async {
                        //                   await FirebaseAuth.instance.currentUser
                        //                       ?.delete();
                        //                   Get.back();
                        //                 },
                        //                 child: const Text('Delete'),
                        //               ),
                        //             ],
                        //           ),
                        //         );
                        //       },
                        //       icon: const Icon(Icons.delete),
                        //       label: const Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Text(
                        //           'Delete Account',
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: selectScreen,
                  onTap: (int screenNumber) {
                    setState(
                      () {
                        selectScreen = screenNumber;
                      },
                    );
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.qr_code_scanner,
                      ),
                      label: 'Scan',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.qr_code),
                      label: 'Make',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite,
                      ),
                      label: 'Favorite',
                    ),
                  ],
                ),
                body: screens.elementAt(selectScreen),
              ),
            ),
          );
  }
}

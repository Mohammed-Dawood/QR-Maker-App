import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/view/qr/scan/main_qr_scan.dart';
import 'package:qr_maker_app/view/qr/maker/main_qr_make.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/language_controller.dart';
import 'package:qr_maker_app/controller/vibration_controller.dart';
import 'package:qr_maker_app/view/qr/favorite/main_favorite_qr.dart';
import 'package:qr_maker_app/controller/favorite_qr_code_controller.dart';

class MainQr extends StatefulWidget {
  const MainQr({Key? key}) : super(key: key);

  @override
  State<MainQr> createState() => _MainQrState();
}

class _MainQrState extends State<MainQr> {
  int selectScreen = 0;

  List<Widget> screens = [
    const MainQrScan(),
    const MainQrMake(),
    const MainFavoriteQr(),
  ];

  FavoriteQrCodeController favoriteQrCodeController = Get.put(
    FavoriteQrCodeController(),
    permanent: true,
  );

  RateMyApp rateMyApp = RateMyApp(
    minDays: 1,
    remindDays: 1,
    minLaunches: 1,
    remindLaunches: 1,
    appStoreIdentifier: '1623787553?uo=4',
    googlePlayIdentifier: 'com.mohammeddawood.qr_maker_app',
  );

  @override
  void initState() {
    favoriteQrCodeController.getQrImageListFromSharePref();

    rateMyApp.init().then(
      (_) {
        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showRateDialog(
            context,
            title: AppLocalizations.of(context)!.rate_app_title,
            message: AppLocalizations.of(context)!.rate_app_message,
            rateButton: AppLocalizations.of(context)!
                .rate_button, // The dialog "rate" button text.
            noButton: '', // The dialog "no" button text.
            laterButton: AppLocalizations.of(context)!
                .later_button, // The dialog "later" button text.
            listener: (button) {
              // The button click listener (useful if you want to cancel the click event).
              switch (button) {
                case RateMyAppDialogButton.rate:
                  print('Clicked on "Rate".');
                  break;
                case RateMyAppDialogButton.later:
                  print('Clicked on "Later".');
                  break;
                case RateMyAppDialogButton.no:
                  print('Clicked on "No".');
                  break;
              }
              return true; // Return false if you want to cancel the click event.
            },
            ignoreNativeDialog:
                true, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
            onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
                .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
            dialogStyle: DialogStyle(
              titleAlign: TextAlign.center,
              titleStyle: TextStyle(
                fontSize: (MediaQuery.of(context).size.width < 600) ? 20 : 28,
              ),
              messageAlign: TextAlign.start,
              messageStyle: TextStyle(
                color: Colors.white,
                fontSize: (MediaQuery.of(context).size.width < 600) ? 18 : 26,
              ),
            ),
          );
        }
      },
    );

    super.initState();
  }

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    List<String> title = [
      AppLocalizations.of(context)!.scan_qr_code,
      AppLocalizations.of(context)!.make_qr_code,
      AppLocalizations.of(context)!.favorite_qr_code,
    ];
    LanguageController languageController = Get.find();
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
                      children: [
                        Expanded(
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
                                          AppLocalizations.of(context)!
                                              .language,
                                          style: (isScreenWidth(context))
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: (isScreenWidth(context))
                                                ? 1
                                                : 2,
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              value: languageController
                                                  .displayLanguage,
                                              icon: Container(),
                                              items: [
                                                DropdownMenuItem(
                                                  value: "en",
                                                  child: Center(
                                                    child: Text(
                                                      '🇺🇸',
                                                      style: TextStyle(
                                                        fontSize: isScreenWidth(
                                                                context)
                                                            ? 30
                                                            : 35,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: "ar",
                                                  child: Center(
                                                    child: Text(
                                                      '🇸🇦',
                                                      style: TextStyle(
                                                        fontSize: isScreenWidth(
                                                                context)
                                                            ? 30
                                                            : 35,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: "sv",
                                                  child: Center(
                                                    child: Text(
                                                      '🇸🇪',
                                                      style: TextStyle(
                                                        fontSize: isScreenWidth(
                                                                context)
                                                            ? 30
                                                            : 35,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              onChanged:
                                                  (String? codeLanguage) {
                                                languageController
                                                    .changeLanguage(
                                                        codeLanguage!);
                                              },
                                              dropdownColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
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
                                          AppLocalizations.of(context)!.theme,
                                          style: (isScreenWidth(context))
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                        ),
                                        Switch(
                                          value: themeController.initValue,
                                          onChanged:
                                              themeController.switchTheme,
                                          activeTrackColor: Colors.white54,
                                          inactiveTrackColor:
                                              Colors.grey.shade900,
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
                                          AppLocalizations.of(context)!
                                              .vibration,
                                          style: (isScreenWidth(context))
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                        ),
                                        GetBuilder<VibrationController>(
                                          init: VibrationController(),
                                          builder: (VibrationController
                                                  vibrationController) =>
                                              Switch(
                                            value:
                                                vibrationController.initValue,
                                            onChanged: vibrationController
                                                .switchVibration,
                                            activeTrackColor: Colors.white54,
                                            inactiveTrackColor:
                                                Colors.grey.shade900,
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
                        Divider(
                          thickness: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.version,
                              style: (isScreenWidth(context))
                                  ? Theme.of(context).textTheme.bodySmall
                                  : Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
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
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.qr_code_scanner,
                        size: (isScreenWidth(context)) ? 24 : 30,
                      ),
                      label: AppLocalizations.of(context)!.scan,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.qr_code,
                        size: (isScreenWidth(context)) ? 24 : 30,
                      ),
                      label: AppLocalizations.of(context)!.make,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite,
                        size: (isScreenWidth(context)) ? 24 : 30,
                      ),
                      label: AppLocalizations.of(context)!.favorite,
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
                      children: [
                        Expanded(
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
                                          AppLocalizations.of(context)!
                                              .language,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 2,
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              value: languageController
                                                  .displayLanguage,
                                              icon: Container(),
                                              items: const [
                                                DropdownMenuItem(
                                                  value: "en",
                                                  child: Center(
                                                    child: Text(
                                                      '🇺🇸',
                                                      style: TextStyle(
                                                        fontSize: 35,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: "ar",
                                                  child: Center(
                                                    child: Text(
                                                      '🇸🇦',
                                                      style: TextStyle(
                                                        fontSize: 35,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: "sv",
                                                  child: Center(
                                                    child: Text(
                                                      '🇸🇪',
                                                      style: TextStyle(
                                                        fontSize: 35,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              onChanged:
                                                  (String? codeLanguage) {
                                                languageController
                                                    .changeLanguage(
                                                        codeLanguage!);
                                              },
                                              dropdownColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
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
                                          AppLocalizations.of(context)!.theme,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        Switch(
                                          value: themeController.initValue,
                                          onChanged:
                                              themeController.switchTheme,
                                          activeTrackColor: Colors.white54,
                                          inactiveTrackColor:
                                              Colors.grey.shade900,
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
                                          AppLocalizations.of(context)!
                                              .vibration,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        GetBuilder<VibrationController>(
                                          init: VibrationController(),
                                          builder: (VibrationController
                                                  vibrationController) =>
                                              Switch(
                                            value:
                                                vibrationController.initValue,
                                            onChanged: vibrationController
                                                .switchVibration,
                                            activeTrackColor: Colors.white54,
                                            inactiveTrackColor:
                                                Colors.grey.shade900,
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
                        Divider(
                          thickness: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.version,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
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
                  items: [
                    BottomNavigationBarItem(
                      icon: const Icon(
                        Icons.qr_code_scanner,
                        size: 30,
                      ),
                      label: AppLocalizations.of(context)!.scan,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(
                        Icons.qr_code,
                        size: 30,
                      ),
                      label: AppLocalizations.of(context)!.make,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(
                        Icons.favorite,
                        size: 30,
                      ),
                      label: AppLocalizations.of(context)!.favorite,
                    ),
                  ],
                ),
                body: screens.elementAt(selectScreen),
              ),
            ),
          );
  }
}

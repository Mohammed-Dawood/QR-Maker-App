import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/view/qr/scan/main_qr_scan.dart';
import 'package:qr_maker_app/view/qr/maker/main_qr_make.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/language_controller.dart';
import 'package:qr_maker_app/controller/vibration_controller.dart';
import 'package:qr_maker_app/view/qr/favorite/main_favorite_qr.dart';
import 'package:qr_maker_app/controller/favorite_qr_code_controller.dart';
import 'package:qr_maker_app/controller/animation_drop_down_controller.dart';

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
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              const SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: isScreenWidth(context) ? 0 : 5,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(horizontal: 8),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.settings,
                                        size: isScreenWidth(context) ? 24 : 30,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        AppLocalizations.of(context)!.settings,
                                        style: (isScreenWidth(context))
                                            ? Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                            : Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.white54,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: isScreenWidth(context) ? 0 : 5,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(horizontal: 8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.flag,
                                            style: TextStyle(
                                                fontSize: isScreenWidth(context)
                                                    ? 24
                                                    : 30),
                                          ),
                                          const SizedBox(width: 10),
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
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: languageController
                                                .dropDownButtonLanguage
                                            ? Icon(
                                                Icons.close,
                                                size: isScreenWidth(context)
                                                    ? 24
                                                    : 30,
                                              )
                                            : Icon(
                                                Icons.keyboard_arrow_down,
                                                size: isScreenWidth(context)
                                                    ? 30
                                                    : 35,
                                              ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      languageController
                                          .toggleDropDownButtonLanguage();
                                    });
                                  },
                                ),
                              ),
                              languageController.currentLanguage == "ar"
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : AnimationDropDownController(
                                      changeState: languageController
                                          .dropDownButtonLanguage,
                                      durationTime: 100,
                                      firstChildeCard: Card(
                                        margin: EdgeInsets.symmetric(
                                          vertical:
                                              isScreenWidth(context) ? 0 : 5,
                                          horizontal: 8,
                                        ),
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                              const EdgeInsets.all(0),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                '🇮🇶',
                                                style: TextStyle(
                                                    fontSize:
                                                        isScreenWidth(context)
                                                            ? 24
                                                            : 30),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "العربية",
                                                style: (isScreenWidth(context))
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .displaySmall
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            languageController
                                                .changeLanguage("ar");
                                          },
                                        ),
                                      ),
                                    ),
                              languageController.currentLanguage == "en"
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : AnimationDropDownController(
                                      changeState: languageController
                                          .dropDownButtonLanguage,
                                      durationTime: 200,
                                      firstChildeCard: Card(
                                        margin: EdgeInsets.symmetric(
                                          vertical:
                                              isScreenWidth(context) ? 0 : 5,
                                          horizontal: 8,
                                        ),
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                              const EdgeInsets.all(0),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                '🇺🇸',
                                                style: TextStyle(
                                                    fontSize:
                                                        isScreenWidth(context)
                                                            ? 24
                                                            : 30),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "English",
                                                style: (isScreenWidth(context))
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .displaySmall
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            languageController
                                                .changeLanguage("en");
                                          },
                                        ),
                                      ),
                                    ),
                              languageController.currentLanguage == "fr"
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : AnimationDropDownController(
                                      changeState: languageController
                                          .dropDownButtonLanguage,
                                      durationTime: 300,
                                      firstChildeCard: Card(
                                        margin: EdgeInsets.symmetric(
                                          vertical:
                                              isScreenWidth(context) ? 0 : 5,
                                          horizontal: 8,
                                        ),
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                              const EdgeInsets.all(0),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                '🇫🇷',
                                                style: TextStyle(
                                                    fontSize:
                                                        isScreenWidth(context)
                                                            ? 24
                                                            : 30),
                                              ),
                                              // Icon(
                                              //   Icons.translate,
                                              //   size: isScreenWidth(context)
                                              //       ? 24
                                              //       : 30,
                                              // ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "Français",
                                                style: (isScreenWidth(context))
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .displaySmall
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            languageController
                                                .changeLanguage("fr");
                                          },
                                        ),
                                      ),
                                    ),
                              languageController.currentLanguage == "sv"
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : AnimationDropDownController(
                                      changeState: languageController
                                          .dropDownButtonLanguage,
                                      durationTime: 400,
                                      firstChildeCard: Card(
                                        margin: EdgeInsets.symmetric(
                                          vertical:
                                              isScreenWidth(context) ? 0 : 5,
                                          horizontal: 8,
                                        ),
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                              const EdgeInsets.all(0),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                '🇸🇪',
                                                style: TextStyle(
                                                    fontSize:
                                                        isScreenWidth(context)
                                                            ? 24
                                                            : 30),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "Svenska",
                                                style: (isScreenWidth(context))
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .displaySmall
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            languageController
                                                .changeLanguage("sv");
                                          },
                                        ),
                                      ),
                                    ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: isScreenWidth(context) ? 0 : 5,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(horizontal: 8),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            themeController.initValue
                                                ? Icons.dark_mode
                                                : Icons.light_mode,
                                            size: isScreenWidth(context)
                                                ? 24
                                                : 30,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 10),
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
                                        ],
                                      ),
                                      Switch(
                                        value: themeController.initValue,
                                        onChanged: themeController.switchTheme,
                                        activeTrackColor: Colors.white54,
                                        inactiveTrackColor:
                                            Colors.grey.shade900,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: isScreenWidth(context) ? 0 : 5,
                                ),
                                child: GetBuilder<VibrationController>(
                                  init: VibrationController(),
                                  builder: (VibrationController
                                          vibrationController) =>
                                      TextButton(
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.symmetric(
                                            horizontal: 8),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              vibrationController.initValue
                                                  ? Icons.notifications_active
                                                  : Icons.notifications_off,
                                              size: isScreenWidth(context)
                                                  ? 24
                                                  : 30,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 10),
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
                                          ],
                                        ),
                                        Switch(
                                          value: vibrationController.initValue,
                                          onChanged: vibrationController
                                              .switchVibration,
                                          activeTrackColor: Colors.white54,
                                          inactiveTrackColor:
                                              Colors.grey.shade900,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: isScreenWidth(context) ? 0 : 5,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(horizontal: 8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.email,
                                        size: isScreenWidth(context) ? 24 : 30,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .contact_us,
                                        style: (isScreenWidth(context))
                                            ? Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                            : Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    Uri mail = Uri.parse(
                                      "mailto:qr.maker.app@gmail.com?subject=QR Maker App&body=Hello,",
                                    );
                                    if (await canLaunchUrl(mail)) {
                                      await launchUrl(mail);
                                    } else {
                                      throw 'Could not launch $mail';
                                    }
                                  },
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
                        const Divider(
                          thickness: 1,
                          color: Colors.white54,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.version,
                              style: (isScreenWidth(context))
                                  ? Theme.of(context).textTheme.displaySmall
                                  : Theme.of(context).textTheme.displayMedium,
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              const SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(horizontal: 8),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.settings,
                                        size: 30,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        AppLocalizations.of(context)!.settings,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.white54,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(horizontal: 8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.flag,
                                            style:
                                                const TextStyle(fontSize: 30),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .language,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: languageController
                                                .dropDownButtonLanguage
                                            ? const Icon(
                                                Icons.close,
                                                size: 30,
                                              )
                                            : const Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 35,
                                              ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      languageController
                                          .toggleDropDownButtonLanguage();
                                    });
                                  },
                                ),
                              ),
                              languageController.currentLanguage == "ar"
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : AnimationDropDownController(
                                      changeState: languageController
                                          .dropDownButtonLanguage,
                                      durationTime: 100,
                                      firstChildeCard: Card(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 8,
                                        ),
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                              const EdgeInsets.all(0),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const Text(
                                                '🇮🇶',
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "العربية",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            languageController
                                                .changeLanguage("ar");
                                          },
                                        ),
                                      ),
                                    ),
                              languageController.currentLanguage == "en"
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : AnimationDropDownController(
                                      changeState: languageController
                                          .dropDownButtonLanguage,
                                      durationTime: 200,
                                      firstChildeCard: Card(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 8,
                                        ),
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                              const EdgeInsets.all(0),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const Text(
                                                '🇺🇸',
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "English",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            languageController
                                                .changeLanguage("en");
                                          },
                                        ),
                                      ),
                                    ),
                              languageController.currentLanguage == "fr"
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : AnimationDropDownController(
                                      changeState: languageController
                                          .dropDownButtonLanguage,
                                      durationTime: 300,
                                      firstChildeCard: Card(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 8,
                                        ),
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                              const EdgeInsets.all(0),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const Text(
                                                '🇫🇷',
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "Français",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            languageController
                                                .changeLanguage("fr");
                                          },
                                        ),
                                      ),
                                    ),
                              languageController.currentLanguage == "sv"
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : AnimationDropDownController(
                                      changeState: languageController
                                          .dropDownButtonLanguage,
                                      durationTime: 400,
                                      firstChildeCard: Card(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 8,
                                        ),
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                              const EdgeInsets.all(0),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const Text(
                                                '🇸🇪',
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "Svenska",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            languageController
                                                .changeLanguage("sv");
                                          },
                                        ),
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(horizontal: 8),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            themeController.initValue
                                                ? Icons.dark_mode
                                                : Icons.light_mode,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            AppLocalizations.of(context)!.theme,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                        ],
                                      ),
                                      Switch(
                                        value: themeController.initValue,
                                        onChanged: themeController.switchTheme,
                                        activeTrackColor: Colors.white54,
                                        inactiveTrackColor:
                                            Colors.grey.shade900,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: GetBuilder<VibrationController>(
                                  init: VibrationController(),
                                  builder: (VibrationController
                                          vibrationController) =>
                                      TextButton(
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.symmetric(
                                            horizontal: 8),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              vibrationController.initValue
                                                  ? Icons.notifications_active
                                                  : Icons.notifications_off,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .vibration,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                            ),
                                          ],
                                        ),
                                        Switch(
                                          value: vibrationController.initValue,
                                          onChanged: vibrationController
                                              .switchVibration,
                                          activeTrackColor: Colors.white54,
                                          inactiveTrackColor:
                                              Colors.grey.shade900,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(horizontal: 8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.email,
                                        size: 30,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .contact_us,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    Uri mail = Uri.parse(
                                      "mailto:qr.maker.app@gmail.com?subject=QR Maker App&body=Hello,",
                                    );
                                    if (await canLaunchUrl(mail)) {
                                      await launchUrl(mail);
                                    } else {
                                      throw 'Could not launch $mail';
                                    }
                                  },
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
                        const Divider(
                          thickness: 1,
                          color: Colors.white54,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.version,
                              style: Theme.of(context).textTheme.displayMedium,
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

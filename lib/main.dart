import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_maker_app/l10n/l10n.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:qr_maker_app/view/qr/main_qr.dart';
import 'package:qr_maker_app/themes/dark_theme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_maker_app/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/language_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:qr_maker_app/view/registration/main_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await initialization(null);
  await GetStorage.init();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  // await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LanguageController languageController = Get.put(LanguageController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: LightTheme.lightTheme,
      darkTheme: DarkTheme.darkTheme,
      themeMode: ThemeController().theme,
      locale: languageController.initialLanguage,
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // home: const MainSignIn(),
      home: AnimatedSplashScreen(
        centered: true,
        duration: 1000,
        splashIconSize: 150,
        curve: Curves.elasticOut,
        nextScreen: const MainQr(),
        splash: 'images/ios_dark_splash.png',
        backgroundColor: const Color(0xFF212121),
        pageTransitionType: PageTransitionType.fade,
        animationDuration: const Duration(milliseconds: 4000),
        splashTransition: SplashTransition.rotationTransition,
      ),
    );
  }
}

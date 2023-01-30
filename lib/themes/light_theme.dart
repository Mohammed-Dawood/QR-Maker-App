import 'package:flutter/material.dart';

class LightTheme {
  static final lightTheme = ThemeData.light().copyWith(
    hintColor: Colors.blue.shade200,
    primaryColor: Colors.blue.shade500,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      displaySmall: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: const TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade500,
      ),
      bodyMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade500,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.blue.shade500,
      elevation: 5,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue.shade500),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(5),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    drawerTheme: DrawerThemeData(
      elevation: 5,
      backgroundColor: Colors.blue.shade500,
    ),
    cardTheme: CardTheme(
      elevation: 5,
      color: Colors.blue.shade500,
      margin: const EdgeInsets.all(10),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.white),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade500,
      onPrimary: Colors.white,
      onSurface: Colors.white,
    ),
    sliderTheme: SliderThemeData(
      thumbColor: Colors.white,
      activeTrackColor: Colors.white54,
      inactiveTrackColor: Colors.grey.shade900,
      disabledActiveTrackColor: Colors.black38,
      disabledInactiveTrackColor: Colors.black38,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ), // button text color
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.blue.shade500,
    ),
    timePickerTheme: TimePickerThemeData(
      dialTextColor: Colors.black,
      hourMinuteColor: Colors.white,
      entryModeIconColor: Colors.white,
      dialBackgroundColor: Colors.white,
      hourMinuteTextColor: Colors.black,
      dialHandColor: Colors.blue.shade200,
      backgroundColor: Colors.blue.shade500,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue.shade200,
          width: 3,
        ),
      ),
    ),
  );
}

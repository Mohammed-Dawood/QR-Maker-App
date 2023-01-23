import 'package:flutter/material.dart';

class DarkTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    hintColor: Colors.black45,
    primaryColor: Colors.grey.shade800,
    scaffoldBackgroundColor: Colors.grey.shade900,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.grey.shade800,
      elevation: 5,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black45,
      backgroundColor: Colors.grey.shade800,
      selectedLabelStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey.shade800),
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
      backgroundColor: Colors.grey.shade800,
    ),
    cardTheme: CardTheme(
      elevation: 5,
      color: Colors.grey.shade800,
      margin: const EdgeInsets.all(10),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.white),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.grey.shade800,
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
      backgroundColor: Colors.grey.shade800,
    ),
    timePickerTheme: TimePickerThemeData(
      dialTextColor: Colors.black,
      dialHandColor: Colors.black45,
      hourMinuteColor: Colors.white,
      entryModeIconColor: Colors.white,
      dialBackgroundColor: Colors.white,
      hourMinuteTextColor: Colors.black,
      backgroundColor: Colors.grey.shade800,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black45,
          width: 3,
        ),
      ),
    ),
  );
}

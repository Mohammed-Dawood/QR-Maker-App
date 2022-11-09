import 'package:flutter/material.dart';

class LightTheme {
  static final lightTheme = ThemeData.light().copyWith(
    hintColor: Colors.black45,
    primaryColor: Colors.blue.shade500,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      displaySmall: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: const TextStyle(
        fontSize: 26,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: const TextStyle(
        fontSize: 26,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade500,
      ),
      bodyMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade500,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.blue.shade500,
      elevation: 10,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black45,
      backgroundColor: Colors.blue.shade500,
      selectedLabelStyle: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue.shade500),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(10),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    drawerTheme: const DrawerThemeData(
      elevation: 10,
    ),
    cardTheme: CardTheme(
      elevation: 10,
      color: Colors.blue.shade500,
      margin: const EdgeInsets.all(10),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.white),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade500,
      onPrimary: Colors.white,
      onSurface: Colors.black,
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
      backgroundColor: Colors.blue.shade200,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.blue.shade200,
    ),
  );
}

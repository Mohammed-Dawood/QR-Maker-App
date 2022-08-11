import 'package:flutter/material.dart';

class LightTheme {
  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue.shade500,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.black54,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.blue,
        fontSize: 18,
        fontWeight: FontWeight.bold,
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
      backgroundColor: Colors.blue.shade500,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black45,
      selectedLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue.shade500),
        elevation: MaterialStateProperty.all(10),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
      elevation: 10,
    ),
    cardTheme: CardTheme(
      color: Colors.blue.shade500,
      elevation: 10,
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
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ), // button text color
      ),
    ),
    hintColor: Colors.black45,
    dialogTheme: DialogTheme(
      backgroundColor: Colors.blue.shade200,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.blue.shade200,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue.shade500,
    ),
  );
}

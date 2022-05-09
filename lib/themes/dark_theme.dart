import 'package:flutter/material.dart';

class DarkTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.grey.shade800,
    scaffoldBackgroundColor: Colors.grey.shade900,
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 25,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.white54,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.red,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.grey.shade800,
      elevation: 10,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade800,
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
        backgroundColor: MaterialStateProperty.all(Colors.grey.shade800),
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
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey.shade900,
      elevation: 10,
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade800,
      elevation: 10,
      margin: const EdgeInsets.all(10),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.white),
      trackColor: MaterialStateProperty.all(Colors.grey.shade900),
    ),
    hintColor: Colors.black45,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.red,
    ),
  );
}
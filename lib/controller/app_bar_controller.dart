import 'package:flutter/material.dart';

AppBar appBarController(
  BuildContext context, {
  required String title,
}) {
  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: (isScreenWidth(context)) ? 18 : 24),
    ),
    iconTheme: IconThemeData(
      size: (isScreenWidth(context)) ? 22 : 26,
      color: Theme.of(context).iconTheme.color,
    ),
  );
}

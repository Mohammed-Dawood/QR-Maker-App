import 'package:flutter/material.dart';

bool isScreenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width < 600;

Icon iconController(BuildContext context, {required IconData icon}) {
  return Icon(
    icon,
    color: Theme.of(context).iconTheme.color,
    size: (isScreenWidth(context)) ? 22 : 26,
  );
}

Icon prefixIconController(BuildContext context, {required IconData icon}) {
  return Icon(
    icon,
    color: Theme.of(context).primaryColor,
    size: (isScreenWidth(context)) ? 22 : 26,
  );
}

Icon suffixIconController(BuildContext context, {required IconData icon}) {
  return Icon(
    icon,
    color: Theme.of(context).primaryColor,
    size: (isScreenWidth(context)) ? 22 : 26,
  );
}

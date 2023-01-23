import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

bool isScreenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width < 600;

Padding labelController(BuildContext context, {required String label}) {
  return Padding(
    padding: (isScreenWidth(context))
        ? const EdgeInsets.symmetric(
            vertical: 16,
          )
        : const EdgeInsets.symmetric(
            vertical: 18,
          ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: (isScreenWidth(context)) ? 16 : 22,
      ),
      maxLines: 1,
    ),
  );
}

Padding labelCreateQRCodeController(BuildContext context) {
  return Padding(
    padding: (isScreenWidth(context))
        ? const EdgeInsets.symmetric(
            vertical: 16,
          )
        : const EdgeInsets.symmetric(
            vertical: 18,
          ),
    child: Text(
      AppLocalizations.of(context)!.create_qr_code,
      style: TextStyle(
        fontSize: (isScreenWidth(context)) ? 16 : 22,
      ),
      maxLines: 1,
    ),
  );
}

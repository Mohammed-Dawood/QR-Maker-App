import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_maker_app/controller/background_controller.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_maker_app/controller/icons_controller.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/controller/app_bar_controller.dart';
import 'package:qr_maker_app/controller/labels_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';

class MakeDate extends StatefulWidget {
  const MakeDate({Key? key}) : super(key: key);

  @override
  State<MakeDate> createState() => _MakeDateState();
}

class _MakeDateState extends State<MakeDate> {
  var valueQr = '';
  DateTime initialDate = DateTime.now();
  TimeOfDay timeStart = const TimeOfDay(hour: 00, minute: 00);
  TimeOfDay timeEnd = const TimeOfDay(hour: 00, minute: 00);

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventAddressController = TextEditingController();
  TextEditingController eventDateEndController = TextEditingController();
  TextEditingController eventTimeEndController = TextEditingController();
  TextEditingController eventDateStartController = TextEditingController();
  TextEditingController eventTimeStartController = TextEditingController();
  TextEditingController eventDateEndControllerQR = TextEditingController();
  TextEditingController eventDateStartControllerQR = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    eventTitleController.addListener(() => setState(() {}));
    eventAddressController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MediaQuery.of(context).orientation == Orientation.portrait
          ? GetBuilder<ThemeController>(
              init: ThemeController(),
              builder: (ThemeController controller) => Container(
                alignment: Alignment.center,
                decoration: backgroundController(controller),
                child: Scaffold(
                  appBar: appBarController(
                    context,
                    title: AppLocalizations.of(context)!.event,
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: validateKey,
                        child: Padding(
                          padding: isScreenWidth(context)
                              ? const EdgeInsets.symmetric(horizontal: 40)
                              : const EdgeInsets.symmetric(horizontal: 130),
                          child: Column(
                            children: [
                              Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (isNull(value)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_the_event_name;
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: eventTitleController,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .event_name,
                                    prefixIcon: Icon(
                                      Icons.event_note,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                    suffixIcon: eventTitleController
                                            .text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                eventTitleController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (isNull(value)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_the_event_address;
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: eventAddressController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .event_address,
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                    suffixIcon: eventAddressController
                                            .text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                eventAddressController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (isNull(value)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_the_event_date_start;
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: eventDateStartController,
                                  textInputAction: TextInputAction.next,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(DateTime.now().year),
                                      lastDate: DateTime(2100),
                                      initialDatePickerMode: DatePickerMode.day,
                                      selectableDayPredicate: (DateTime day) {
                                        if ((day.isAfter(
                                          DateTime.now().subtract(
                                            const Duration(days: 1),
                                          ),
                                        ))) {
                                          return true;
                                        }
                                        return false;
                                      },
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                    );

                                    if (newDate != null) {
                                      setState(
                                        () {
                                          initialDate = newDate;
                                          eventDateStartController.text =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(newDate);
                                          eventDateStartControllerQR.text =
                                              DateFormat('yyyyMMdd')
                                                  .format(newDate);
                                        },
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .event_date_start,
                                    prefixIcon: Icon(
                                      Icons.event_available,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (isNull(value)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_the_event_time_start;
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: eventTimeStartController,
                                  textInputAction: TextInputAction.next,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: timeStart,
                                      initialEntryMode:
                                          TimePickerEntryMode.dial,
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                            alwaysUse24HourFormat: true,
                                          ),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!,
                                        );
                                      },
                                    );

                                    if (newTime != null) {
                                      setState(
                                        () {
                                          timeStart = newTime;
                                          eventTimeStartController.text =
                                              newTime.format(context);
                                        },
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .event_time_start,
                                    prefixIcon: Icon(
                                      Icons.access_time_outlined,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (isNull(value)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_the_event_date_end;
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: eventDateEndController,
                                  textInputAction: TextInputAction.next,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(initialDate.year),
                                      lastDate: DateTime(2100),
                                      initialDatePickerMode: DatePickerMode.day,
                                      selectableDayPredicate: (DateTime day) {
                                        if ((day.isAfter(
                                          initialDate.subtract(
                                            const Duration(days: 1),
                                          ),
                                        ))) {
                                          return true;
                                        }
                                        return false;
                                      },
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                    );
                                    if (newDate != null) {
                                      setState(
                                        () {
                                          eventDateEndController.text =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(newDate);
                                          eventDateEndControllerQR.text =
                                              DateFormat('yyyyMMdd')
                                                  .format(newDate);
                                        },
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .event_date_end,
                                    prefixIcon: Icon(
                                      Icons.event_available,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (isNull(value)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_the_event_time_end;
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: eventTimeEndController,
                                  textInputAction: TextInputAction.next,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: timeEnd,
                                      initialEntryMode:
                                          TimePickerEntryMode.dial,
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                            alwaysUse24HourFormat: true,
                                          ),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (newTime != null) {
                                      setState(
                                        () {
                                          timeEnd = newTime;
                                          eventTimeEndController.text =
                                              newTime.format(context);
                                        },
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .event_time_end,
                                    prefixIcon: Icon(
                                      Icons.access_time_outlined,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.transparent,
                                shadowColor: Colors.transparent,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (validateKey.currentState!
                                          .validate()) {
                                        setState(
                                          () {
                                            valueQr = [
                                              "BEGIN:VEVENT",
                                              "SUMMARY:${eventTitleController.text.toString()}",
                                              "LOCATION:${eventAddressController.text.toString()}",
                                              "DTSTART:${eventDateStartControllerQR.text.toString()}T${timeStart.hour.toString().padLeft(2, '0')}${timeStart.minute.toString().padLeft(2, '0')}00",
                                              "DTEND:${eventDateEndControllerQR.text.toString()}T${timeEnd.hour.toString().padLeft(2, '0')}${timeEnd.minute.toString().padLeft(2, '0')}00",
                                              "END:VEVENT",
                                            ].join("\r\n");

                                            Get.to(() =>
                                                StyleShareSaveFavoriteQrCode(
                                                  valueQr: valueQr,
                                                  image: 'images/date.png',
                                                  versionValueWithLogo:
                                                      QrVersions.auto,
                                                ));
                                          },
                                        );
                                      }
                                    },
                                    icon: iconController(
                                      context,
                                      icon: Icons.touch_app,
                                    ),
                                    label: labelCreateQRCodeController(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : GetBuilder<ThemeController>(
              init: ThemeController(),
              builder: (ThemeController controller) => Container(
                alignment: Alignment.center,
                decoration: backgroundController(controller),
                child: Scaffold(
                  appBar: appBarController(
                    context,
                    title: AppLocalizations.of(context)!.event,
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: validateKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 230),
                          child: Column(
                            children: [
                              Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (isNull(value)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_the_event_name;
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: eventTitleController,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .event_name,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.event_note,
                                    ),
                                    suffixIcon: eventTitleController
                                            .text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                eventTitleController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (isNull(value)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_the_event_address;
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: eventAddressController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .event_address,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.location_on,
                                    ),
                                    suffixIcon: eventAddressController
                                            .text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                eventAddressController.clear(),
                                            icon: suffixIconController(
                                              context,
                                              icon: Icons.close,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (isNull(value)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_the_event_date_start;
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: eventDateStartController,
                                  textInputAction: TextInputAction.next,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(DateTime.now().year),
                                      lastDate: DateTime(2100),
                                      initialDatePickerMode: DatePickerMode.day,
                                      selectableDayPredicate: (DateTime day) {
                                        if ((day.isAfter(
                                          DateTime.now().subtract(
                                            const Duration(days: 1),
                                          ),
                                        ))) {
                                          return true;
                                        }
                                        return false;
                                      },
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                    );

                                    if (newDate != null) {
                                      setState(
                                        () {
                                          initialDate = newDate;
                                          eventDateStartController.text =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(newDate);
                                          eventDateStartControllerQR.text =
                                              DateFormat('yyyyMMdd')
                                                  .format(newDate);
                                        },
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .event_date_start,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.event_available,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (isNull(value)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_the_event_time_start;
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: eventTimeStartController,
                                  textInputAction: TextInputAction.next,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: timeStart,
                                      initialEntryMode:
                                          TimePickerEntryMode.dial,
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                            alwaysUse24HourFormat: true,
                                          ),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!,
                                        );
                                      },
                                    );

                                    if (newTime != null) {
                                      setState(
                                        () {
                                          timeStart = newTime;
                                          eventTimeStartController.text =
                                              newTime.format(context);
                                        },
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .event_time_start,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.access_time_outlined,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (isNull(value)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_the_event_date_end;
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: eventDateEndController,
                                  textInputAction: TextInputAction.next,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(initialDate.year),
                                      lastDate: DateTime(2100),
                                      initialDatePickerMode: DatePickerMode.day,
                                      selectableDayPredicate: (DateTime day) {
                                        if ((day.isAfter(
                                          initialDate.subtract(
                                            const Duration(days: 1),
                                          ),
                                        ))) {
                                          return true;
                                        }
                                        return false;
                                      },
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                    );
                                    if (newDate != null) {
                                      setState(
                                        () {
                                          eventDateEndController.text =
                                              DateFormat('yyyy/MM/dd')
                                                  .format(newDate);
                                          eventDateEndControllerQR.text =
                                              DateFormat('yyyyMMdd')
                                                  .format(newDate);
                                        },
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .event_date_end,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.event_available,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (isNull(value)) {
                                      return AppLocalizations.of(context)!
                                          .please_enter_the_event_time_end;
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: eventTimeEndController,
                                  textInputAction: TextInputAction.next,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: timeEnd,
                                      initialEntryMode:
                                          TimePickerEntryMode.dial,
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            // Using 12-Hour format
                                            alwaysUse24HourFormat: true,
                                          ),
                                          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (newTime != null) {
                                      setState(
                                        () {
                                          timeEnd = newTime;
                                          eventTimeEndController.text =
                                              newTime.format(context);
                                        },
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .event_time_end,
                                    prefixIcon: prefixIconController(
                                      context,
                                      icon: Icons.access_time_outlined,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.transparent,
                                shadowColor: Colors.transparent,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (validateKey.currentState!
                                          .validate()) {
                                        setState(
                                          () {
                                            valueQr = [
                                              "BEGIN:VEVENT",
                                              "SUMMARY:${eventTitleController.text.toString()}",
                                              "LOCATION:${eventAddressController.text.toString()}",
                                              "DTSTART:${eventDateStartControllerQR.text.toString()}T${timeStart.hour.toString().padLeft(2, '0')}${timeStart.minute.toString().padLeft(2, '0')}00",
                                              "DTEND:${eventDateEndControllerQR.text.toString()}T${timeEnd.hour.toString().padLeft(2, '0')}${timeEnd.minute.toString().padLeft(2, '0')}00",
                                              "END:VEVENT",
                                            ].join("\r\n");

                                            Get.to(() =>
                                                StyleShareSaveFavoriteQrCode(
                                                  valueQr: valueQr,
                                                  image: 'images/date.png',
                                                  versionValueWithLogo:
                                                      QrVersions.auto,
                                                ));
                                          },
                                        );
                                      }
                                    },
                                    icon: iconController(
                                      context,
                                      icon: Icons.touch_app,
                                    ),
                                    label: labelCreateQRCodeController(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

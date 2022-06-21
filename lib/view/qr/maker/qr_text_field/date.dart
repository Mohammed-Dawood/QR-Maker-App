import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/maker/qr_style_and_share.dart';

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
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (ThemeController controller) => Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: controller.initValue
                ? const AssetImage('images/background_dark.png')
                : const AssetImage('images/background_light.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: validateKey,
                child: Padding(
                  padding: isScreenWidth(context)
                      ? const EdgeInsets.symmetric(horizontal: 10)
                      : const EdgeInsets.symmetric(horizontal: 100),
                  child: Column(
                    children: [
                      Card(
                        child: TextFormField(
                          validator: (value) {
                            if (isNull(value)) {
                              return 'Please enter a Event Name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorWidth: 3,
                          controller: eventTitleController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Event Title',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.event_note,
                              color: Theme.of(context).primaryColor,
                            ),
                            suffixIcon: eventTitleController.text.isEmpty
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    onPressed: () =>
                                        eventTitleController.clear(),
                                    icon: Icon(
                                      Icons.close,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: TextFormField(
                          validator: (value) {
                            if (isNull(value)) {
                              return 'Please enter a Event Address';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorWidth: 3,
                          controller: eventAddressController,
                          keyboardType: TextInputType.streetAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Event Address',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Theme.of(context).primaryColor,
                            ),
                            suffixIcon: eventAddressController.text.isEmpty
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    onPressed: () =>
                                        eventAddressController.clear(),
                                    icon: Icon(
                                      Icons.close,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: TextFormField(
                          validator: (value) {
                            if (isNull(value)) {
                              return 'Please enter a Event Date';
                            }
                            return null;
                          },
                          readOnly: true,
                          controller: eventDateStartController,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () async {
                            // Below line stops keyboard from appearing
                            FocusScope.of(context).requestFocus(FocusNode());
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
                                      DateFormat('yyyy/MM/dd').format(newDate);
                                  eventDateStartControllerQR.text =
                                      DateFormat('yyyyMMdd').format(newDate);
                                },
                              );
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Event Date Start',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.event_available,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: TextFormField(
                          validator: (value) {
                            if (isNull(value)) {
                              return 'Please enter a Event Time';
                            }
                            return null;
                          },
                          readOnly: true,
                          controller: eventTimeStartController,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () async {
                            // Below line stops keyboard from appearing
                            FocusScope.of(context).requestFocus(FocusNode());
                            TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: timeStart,
                              initialEntryMode: TimePickerEntryMode.dial,
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
                            hintText: 'Event Time Start',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.access_time_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: TextFormField(
                          validator: (value) {
                            if (isNull(value)) {
                              return 'Please enter a Event Date';
                            }
                            return null;
                          },
                          readOnly: true,
                          controller: eventDateEndController,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () async {
                            // Below line stops keyboard from appearing
                            FocusScope.of(context).requestFocus(FocusNode());
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
                                      DateFormat('yyyy/MM/dd').format(newDate);
                                  eventDateEndControllerQR.text =
                                      DateFormat('yyyyMMdd').format(newDate);
                                },
                              );
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Event Date End',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.event_available,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: TextFormField(
                          validator: (value) {
                            if (isNull(value)) {
                              return 'Please enter a Event Time';
                            }
                            return null;
                          },
                          readOnly: true,
                          controller: eventTimeEndController,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () async {
                            // Below line stops keyboard from appearing
                            FocusScope.of(context).requestFocus(FocusNode());
                            TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: timeEnd,
                              initialEntryMode: TimePickerEntryMode.dial,
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
                            hintText: 'Event Time End',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.access_time_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (validateKey.currentState!.validate()) {
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
                                        QrStyleAndShare(valueQr: valueQr));
                                  },
                                );
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              child: Text('Create QR Code'),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.back();
                            },
                            label: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              child: Text('Back'),
                            ),
                            icon: const Icon(Icons.arrow_back_ios_new),
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
    );
  }
}

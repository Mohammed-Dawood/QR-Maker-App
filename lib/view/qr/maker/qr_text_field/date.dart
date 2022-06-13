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

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventAddressController = TextEditingController();
  TextEditingController eventDateEndController = TextEditingController();
  TextEditingController eventTimeEndController = TextEditingController();
  TextEditingController eventDateStartController = TextEditingController();
  TextEditingController eventTimeStartController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

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
                      ? const EdgeInsets.symmetric(horizontal: 20)
                      : const EdgeInsets.symmetric(horizontal: 80),
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
                          cursorWidth: 3,
                          readOnly: true,
                          controller: eventDateStartController,
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () async {
                            // Below line stops keyboard from appearing
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 5),
                              lastDate: DateTime(DateTime.now().year + 5),
                              initialDatePickerMode: DatePickerMode.year,
                            );

                            if (newDate != null) {
                              String formattedDate =
                                  DateFormat('yyyyMMdd').format(newDate);
                              setState(
                                () {
                                  eventDateStartController.text =
                                      formattedDate; //set output date to TextField value.
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
                          cursorWidth: 3,
                          readOnly: true,
                          controller: eventTimeStartController,
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () async {
                            // Below line stops keyboard from appearing
                            FocusScope.of(context).requestFocus(FocusNode());
                            TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (newTime != null) {
                              String formattedTime = DateFormat('HHmm').format(
                                DateFormat.jm().parse(
                                  newTime.format(context).toString(),
                                ),
                              );
                              setState(
                                () {
                                  eventTimeStartController.text =
                                      formattedTime; //set output date to TextField value.
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
                          cursorWidth: 3,
                          readOnly: true,
                          controller: eventDateEndController,
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () async {
                            // Below line stops keyboard from appearing
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 5),
                              lastDate: DateTime(DateTime.now().year + 5),
                              initialDatePickerMode: DatePickerMode.year,
                            );
                            if (newDate != null) {
                              String formattedDate =
                                  DateFormat('yyyyMMdd').format(newDate);
                              setState(
                                () {
                                  eventDateEndController.text =
                                      formattedDate; //set output date to TextField value.
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
                          cursorWidth: 3,
                          readOnly: true,
                          controller: eventTimeEndController,
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () async {
                            // Below line stops keyboard from appearing
                            FocusScope.of(context).requestFocus(FocusNode());
                            TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (newTime != null) {
                              String formattedTime = DateFormat('HHmm').format(
                                DateFormat.jm().parse(
                                  newTime.format(context).toString(),
                                ),
                              );
                              setState(
                                () {
                                  eventTimeEndController.text =
                                      formattedTime; //set output date to TextField value.
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
                                      "DTSTART:${eventDateStartController.text.toString()}T${eventTimeStartController.text.toString()}00",
                                      "DTEND:${eventDateEndController.text.toString()}T${eventTimeEndController.text.toString()}00",
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

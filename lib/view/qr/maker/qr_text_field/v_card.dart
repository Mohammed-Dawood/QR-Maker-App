import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/maker/qr_style_and_share.dart';

class MakeVCard extends StatefulWidget {
  const MakeVCard({Key? key}) : super(key: key);

  @override
  State<MakeVCard> createState() => _MakeVCardState();
}

class _MakeVCardState extends State<MakeVCard> {
  var valueQr = '';

  var completePhoneNumberFax = '';
  var completePhoneNumberWork = '';
  var completePhoneNumberHome = '';
  var completePhoneNumberMobil = '';

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();

  TextEditingController urlController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bDayController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

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
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Form(
                  key: validateKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Card(
                        child: TextFormField(
                          validator: (String? name) {
                            if (isNull(name)) {
                              return 'Please enter a Wifi Name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorWidth: 3,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Full Name ',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.person,
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
                          cursorWidth: 3,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'name@mail.com',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.email,
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
                        child: IntlPhoneField(
                          validator: (PhoneNumber? phone) {
                            if (!isLength(phone!.number, 8, 20)) {
                              return 'Please enter a valid Phone Number';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorWidth: 3,
                          disableLengthCheck: true,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          dropdownIconPosition: IconPosition.trailing,
                          cursorColor: Theme.of(context).primaryColor,
                          flagsButtonPadding: const EdgeInsets.only(
                            left: 10,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          dropdownTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          pickerDialogStyle: PickerDialogStyle(
                            backgroundColor: Colors.white,
                            countryCodeStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            countryNameStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            searchFieldCursorColor: Colors.white,
                            searchFieldInputDecoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).primaryColor,
                              label: const Text('Search country'),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Phone(Mobile)',
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            ),
                          ),
                          onChanged: (PhoneNumber phone) {
                            completePhoneNumberMobil = phone.completeNumber;
                          },
                        ),
                      ),
                      Card(
                        child: IntlPhoneField(
                          validator: (PhoneNumber? phone) {
                            if (!isLength(phone!.number, 8, 20)) {
                              return 'Please enter a valid Phone Number';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorWidth: 3,
                          disableLengthCheck: true,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          dropdownIconPosition: IconPosition.trailing,
                          cursorColor: Theme.of(context).primaryColor,
                          flagsButtonPadding: const EdgeInsets.only(
                            left: 10,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          dropdownTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          pickerDialogStyle: PickerDialogStyle(
                            backgroundColor: Colors.white,
                            countryCodeStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            countryNameStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            searchFieldCursorColor: Colors.white,
                            searchFieldInputDecoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).primaryColor,
                              label: const Text('Search country'),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Phone(Work)',
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            ),
                          ),
                          onChanged: (PhoneNumber phone) {
                            completePhoneNumberWork = phone.completeNumber;
                          },
                        ),
                      ),
                      Card(
                        child: IntlPhoneField(
                          validator: (PhoneNumber? phone) {
                            if (!isLength(phone!.number, 8, 20)) {
                              return 'Please enter a valid Phone Number';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorWidth: 3,
                          disableLengthCheck: true,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          dropdownIconPosition: IconPosition.trailing,
                          cursorColor: Theme.of(context).primaryColor,
                          flagsButtonPadding: const EdgeInsets.only(
                            left: 10,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          dropdownTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          pickerDialogStyle: PickerDialogStyle(
                            backgroundColor: Colors.white,
                            countryCodeStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            countryNameStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            searchFieldCursorColor: Colors.white,
                            searchFieldInputDecoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).primaryColor,
                              label: const Text('Search country'),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Phone(Home)',
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            ),
                          ),
                          onChanged: (PhoneNumber phone) {
                            completePhoneNumberHome = phone.completeNumber;
                          },
                        ),
                      ),
                      Card(
                        child: IntlPhoneField(
                          validator: (PhoneNumber? phone) {
                            if (!isLength(phone!.number, 8, 20)) {
                              return 'Please enter a valid Phone Number';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorWidth: 3,
                          disableLengthCheck: true,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          dropdownIconPosition: IconPosition.trailing,
                          cursorColor: Theme.of(context).primaryColor,
                          flagsButtonPadding: const EdgeInsets.only(
                            left: 10,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          dropdownTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          pickerDialogStyle: PickerDialogStyle(
                            backgroundColor: Colors.white,
                            countryCodeStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            countryNameStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            searchFieldCursorColor: Colors.white,
                            searchFieldInputDecoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).primaryColor,
                              label: const Text('Search country'),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Fax',
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            ),
                          ),
                          onChanged: (PhoneNumber phone) {
                            completePhoneNumberFax = phone.completeNumber;
                          },
                        ),
                      ),
                      Card(
                        child: TextFormField(
                          cursorWidth: 3,
                          controller: bDayController,
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
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              initialDatePickerMode: DatePickerMode.year,
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            );
                            if (newDate != null) {
                              String formattedDate =
                                  DateFormat('yyyyMMdd').format(newDate);
                              setState(
                                () {
                                  bDayController.text =
                                      formattedDate; //set output date to TextField value.
                                },
                              );
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Date of birth',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.date_range,
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
                          cursorWidth: 3,
                          controller: urlController,
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'https://www.example.com/',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.link,
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
                          cursorWidth: 3,
                          controller: streetController,
                          keyboardType: TextInputType.streetAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Street address',
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
                          cursorWidth: 3,
                          controller: zipController,
                          keyboardType: TextInputType.streetAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Zip code',
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
                          cursorWidth: 3,
                          controller: cityController,
                          keyboardType: TextInputType.streetAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'City',
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
                          cursorWidth: 3,
                          controller: stateController,
                          keyboardType: TextInputType.streetAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'State',
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
                          cursorWidth: 3,
                          controller: countryController,
                          keyboardType: TextInputType.streetAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Country',
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
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (validateKey.currentState!.validate()) {
                                setState(
                                  () {
                                    valueQr = [
                                      "BEGIN:VCARD",
                                      "VERSION:3.0",
                                      "FN: ${nameController.text.toString()}",
                                      "EMAIL: ${emailController.text.toString()}",
                                      "TEL;TYPE=CELL: $completePhoneNumberMobil",
                                      "TEL;TYPE=WORK: $completePhoneNumberWork",
                                      "TEL;TYPE=Home: $completePhoneNumberHome",
                                      "TEL;TYPE=FAX: $completePhoneNumberFax",
                                      "URL:${urlController.text.toString()}",
                                      "BDAY:${bDayController.text.toString()}",
                                      "ADR;TYPE=home:;;${streetController.text.toString()} ;${cityController.text.toString()};${stateController.text.toString()};${zipController.text.toString()};${countryController.text.toString()} ",
                                      "END:VCARD",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

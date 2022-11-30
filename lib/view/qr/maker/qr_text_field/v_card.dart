import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:validators/validators.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';

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
  TextEditingController faxController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bDayController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    urlController.addListener(() => setState(() {}));
    zipController.addListener(() => setState(() {}));
    faxController.addListener(() => setState(() {}));
    cityController.addListener(() => setState(() {}));
    nameController.addListener(() => setState(() {}));
    workController.addListener(() => setState(() {}));
    homeController.addListener(() => setState(() {}));
    stateController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    mobileController.addListener(() => setState(() {}));
    streetController.addListener(() => setState(() {}));
    countryController.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? GetBuilder<ThemeController>(
            init: ThemeController(),
            builder: (ThemeController controller) => Container(
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
                appBar: AppBar(
                  title: Text(
                    'V-Card QR Code',
                    style:
                        TextStyle(fontSize: (isScreenWidth(context)) ? 20 : 28),
                  ),
                  iconTheme: IconThemeData(
                    size: (isScreenWidth(context)) ? 24 : 30,
                    color: Colors.white,
                  ),
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Form(
                        key: validateKey,
                        child: Padding(
                          padding: isScreenWidth(context)
                              ? const EdgeInsets.symmetric(horizontal: 40)
                              : const EdgeInsets.symmetric(horizontal: 130),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 150,
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (String? name) {
                                    if (isNull(name)) {
                                      return 'Please enter a Wifi Name';
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'Full Name ',
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                    suffixIcon: nameController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                nameController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 26
                                                  : 30,
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
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'name@mail.com',
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                    suffixIcon: emailController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                emailController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: mobileController,
                                  disableLengthCheck: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  dropdownIconPosition: IconPosition.trailing,
                                  cursorColor: Theme.of(context).primaryColor,
                                  flagsButtonPadding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  dropdownTextStyle: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  pickerDialogStyle: PickerDialogStyle(
                                    countryCodeStyle: (isScreenWidth(context))
                                        ? Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                    countryNameStyle: (isScreenWidth(context))
                                        ? Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                    searchFieldCursorColor:
                                        Theme.of(context).primaryColor,
                                    searchFieldInputDecoration: InputDecoration(
                                      hintText: 'Search Country',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            (isScreenWidth(context) ? 18 : 26),
                                      ),
                                      isCollapsed: false,
                                      isDense: true,
                                      suffixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                        size:
                                            (isScreenWidth(context)) ? 24 : 30,
                                      ),
                                    ),
                                    width: isScreenWidth(context)
                                        ? double.infinity
                                        : 500,
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: mobileController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                mobileController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
                                            ),
                                          ),
                                  ),
                                  onChanged: (PhoneNumber phone) {
                                    completePhoneNumberMobil =
                                        phone.completeNumber;
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: workController,
                                  disableLengthCheck: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  dropdownIconPosition: IconPosition.trailing,
                                  cursorColor: Theme.of(context).primaryColor,
                                  flagsButtonPadding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  dropdownTextStyle: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  pickerDialogStyle: PickerDialogStyle(
                                    countryCodeStyle: (isScreenWidth(context))
                                        ? Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                    countryNameStyle: (isScreenWidth(context))
                                        ? Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                    searchFieldCursorColor:
                                        Theme.of(context).primaryColor,
                                    searchFieldInputDecoration: InputDecoration(
                                      hintText: 'Search Country',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            (isScreenWidth(context) ? 18 : 26),
                                      ),
                                      isCollapsed: false,
                                      isDense: true,
                                      suffixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                        size:
                                            (isScreenWidth(context)) ? 24 : 30,
                                      ),
                                    ),
                                    width: isScreenWidth(context)
                                        ? double.infinity
                                        : 500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Phone(Work)',
                                    suffixIcon: workController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                workController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
                                            ),
                                          ),
                                  ),
                                  onChanged: (PhoneNumber phone) {
                                    completePhoneNumberWork =
                                        phone.completeNumber;
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: homeController,
                                  disableLengthCheck: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  dropdownIconPosition: IconPosition.trailing,
                                  cursorColor: Theme.of(context).primaryColor,
                                  flagsButtonPadding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  dropdownTextStyle: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  pickerDialogStyle: PickerDialogStyle(
                                    countryCodeStyle: (isScreenWidth(context))
                                        ? Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                    countryNameStyle: (isScreenWidth(context))
                                        ? Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                    searchFieldCursorColor:
                                        Theme.of(context).primaryColor,
                                    searchFieldInputDecoration: InputDecoration(
                                      hintText: 'Search Country',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            (isScreenWidth(context) ? 18 : 26),
                                      ),
                                      isCollapsed: false,
                                      isDense: true,
                                      suffixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                        size:
                                            (isScreenWidth(context)) ? 24 : 30,
                                      ),
                                    ),
                                    width: isScreenWidth(context)
                                        ? double.infinity
                                        : 500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Phone(Home)',
                                    suffixIcon: homeController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                homeController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
                                            ),
                                          ),
                                  ),
                                  onChanged: (PhoneNumber phone) {
                                    completePhoneNumberHome =
                                        phone.completeNumber;
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: faxController,
                                  disableLengthCheck: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  dropdownIconPosition: IconPosition.trailing,
                                  cursorColor: Theme.of(context).primaryColor,
                                  flagsButtonPadding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  dropdownTextStyle: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  pickerDialogStyle: PickerDialogStyle(
                                    countryCodeStyle: (isScreenWidth(context))
                                        ? Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                    countryNameStyle: (isScreenWidth(context))
                                        ? Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                    searchFieldCursorColor:
                                        Theme.of(context).primaryColor,
                                    searchFieldInputDecoration: InputDecoration(
                                      hintText: 'Search Country',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            (isScreenWidth(context) ? 18 : 26),
                                      ),
                                      isCollapsed: false,
                                      isDense: true,
                                      suffixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                        size:
                                            (isScreenWidth(context)) ? 24 : 30,
                                      ),
                                    ),
                                    width: isScreenWidth(context)
                                        ? double.infinity
                                        : 500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Fax',
                                    suffixIcon: faxController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                faxController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
                                            ),
                                          ),
                                  ),
                                  onChanged: (PhoneNumber phone) {
                                    completePhoneNumberFax =
                                        phone.completeNumber;
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
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                      initialDatePickerMode:
                                          DatePickerMode.year,
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                    );
                                    if (newDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyyMMdd')
                                              .format(newDate);
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
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
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
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'https://www.example.com/',
                                    prefixIcon: Icon(
                                      Icons.link,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                    suffixIcon: urlController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                urlController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
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
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'Street address',
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                    suffixIcon: streetController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                streetController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
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
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'Zip code',
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                    suffixIcon: zipController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                zipController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
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
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'City',
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                    suffixIcon: cityController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                cityController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
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
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'State',
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                    suffixIcon: stateController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                stateController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
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
                                  style: (isScreenWidth(context))
                                      ? Theme.of(context).textTheme.titleSmall
                                      : Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'Country',
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).primaryColor,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                    suffixIcon: countryController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                countryController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: (isScreenWidth(context))
                                                  ? 24
                                                  : 30,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (validateKey.currentState!
                                          .validate()) {
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
                                                StyleShareSaveFavoriteQrCode(
                                                  valueQr: valueQr,
                                                  image: 'images/v-card.png',
                                                  versionValueWithLogo:
                                                      QrVersions.auto,
                                                ));
                                          },
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      Icons.touch_app,
                                      size: (isScreenWidth(context)) ? 24 : 30,
                                    ),
                                    label: Padding(
                                      padding: (isScreenWidth(context))
                                          ? const EdgeInsets.symmetric(
                                              vertical: 18)
                                          : const EdgeInsets.symmetric(
                                              vertical: 20),
                                      child: Text(
                                        'Create QR Code',
                                        style: TextStyle(
                                            fontSize: (isScreenWidth(context))
                                                ? 18
                                                : 26),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : GetBuilder<ThemeController>(
            init: ThemeController(),
            builder: (ThemeController controller) => Container(
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
                appBar: AppBar(
                  title: const Text(
                    'V-Card QR Code',
                    style: TextStyle(fontSize: 28),
                  ),
                  iconTheme: const IconThemeData(
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Form(
                        key: validateKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 230),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Card(
                                child: TextFormField(
                                  validator: (String? name) {
                                    if (isNull(name)) {
                                      return 'Please enter a Wifi Name';
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'Full Name ',
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                    suffixIcon: nameController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                nameController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'name@mail.com',
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                    suffixIcon: emailController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                emailController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: mobileController,
                                  disableLengthCheck: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  dropdownIconPosition: IconPosition.trailing,
                                  cursorColor: Theme.of(context).primaryColor,
                                  flagsButtonPadding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  dropdownTextStyle:
                                      Theme.of(context).textTheme.titleMedium,
                                  pickerDialogStyle: PickerDialogStyle(
                                    countryCodeStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    countryNameStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    searchFieldCursorColor:
                                        Theme.of(context).primaryColor,
                                    searchFieldInputDecoration: InputDecoration(
                                      hintText: 'Search Country',
                                      hintStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                      ),
                                      isCollapsed: false,
                                      isDense: true,
                                      suffixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    width: 500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Phone(Mobile)',
                                    suffixIcon: mobileController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                mobileController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
                                            ),
                                          ),
                                  ),
                                  onChanged: (PhoneNumber phone) {
                                    completePhoneNumberMobil =
                                        phone.completeNumber;
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: workController,
                                  disableLengthCheck: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  dropdownIconPosition: IconPosition.trailing,
                                  cursorColor: Theme.of(context).primaryColor,
                                  flagsButtonPadding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  dropdownTextStyle:
                                      Theme.of(context).textTheme.titleMedium,
                                  pickerDialogStyle: PickerDialogStyle(
                                    countryCodeStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    countryNameStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    searchFieldCursorColor:
                                        Theme.of(context).primaryColor,
                                    searchFieldInputDecoration: InputDecoration(
                                      hintText: 'Search Country',
                                      hintStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                      ),
                                      isCollapsed: false,
                                      isDense: true,
                                      suffixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    width: 500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Phone(Work)',
                                    suffixIcon: workController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                workController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
                                            ),
                                          ),
                                  ),
                                  onChanged: (PhoneNumber phone) {
                                    completePhoneNumberWork =
                                        phone.completeNumber;
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: homeController,
                                  disableLengthCheck: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  dropdownIconPosition: IconPosition.trailing,
                                  cursorColor: Theme.of(context).primaryColor,
                                  flagsButtonPadding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  dropdownTextStyle:
                                      Theme.of(context).textTheme.titleMedium,
                                  pickerDialogStyle: PickerDialogStyle(
                                    countryCodeStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    countryNameStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    searchFieldCursorColor:
                                        Theme.of(context).primaryColor,
                                    searchFieldInputDecoration: InputDecoration(
                                      hintText: 'Search Country',
                                      hintStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                      ),
                                      isCollapsed: false,
                                      isDense: true,
                                      suffixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    width: 500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Phone(Home)',
                                    suffixIcon: homeController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                homeController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
                                            ),
                                          ),
                                  ),
                                  onChanged: (PhoneNumber phone) {
                                    completePhoneNumberHome =
                                        phone.completeNumber;
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorWidth: 3,
                                  controller: faxController,
                                  disableLengthCheck: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  dropdownIconPosition: IconPosition.trailing,
                                  cursorColor: Theme.of(context).primaryColor,
                                  flagsButtonPadding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  dropdownTextStyle:
                                      Theme.of(context).textTheme.titleMedium,
                                  pickerDialogStyle: PickerDialogStyle(
                                    countryCodeStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    countryNameStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    searchFieldCursorColor:
                                        Theme.of(context).primaryColor,
                                    searchFieldInputDecoration: InputDecoration(
                                      hintText: 'Search Country',
                                      hintStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                      ),
                                      isCollapsed: false,
                                      isDense: true,
                                      suffixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    width: 500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Fax',
                                    suffixIcon: faxController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                faxController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
                                            ),
                                          ),
                                  ),
                                  onChanged: (PhoneNumber phone) {
                                    completePhoneNumberFax =
                                        phone.completeNumber;
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  onTap: () async {
                                    // Below line stops keyboard from appearing
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                      initialDatePickerMode:
                                          DatePickerMode.year,
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                    );
                                    if (newDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyyMMdd')
                                              .format(newDate);
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
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'https://www.example.com/',
                                    prefixIcon: Icon(
                                      Icons.link,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                    suffixIcon: urlController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                urlController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'Street address',
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                    suffixIcon: streetController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                streetController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'Zip code',
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                    suffixIcon: zipController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                zipController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'City',
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                    suffixIcon: cityController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                cityController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'State',
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                    suffixIcon: stateController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                stateController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  decoration: InputDecoration(
                                    hintText: 'Country',
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                    suffixIcon: countryController.text.isEmpty
                                        ? Container(
                                            width: 0,
                                          )
                                        : IconButton(
                                            onPressed: () =>
                                                countryController.clear(),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Card(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (validateKey.currentState!
                                          .validate()) {
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
                                                StyleShareSaveFavoriteQrCode(
                                                  valueQr: valueQr,
                                                  image: 'images/v-card.png',
                                                  versionValueWithLogo:
                                                      QrVersions.auto,
                                                ));
                                          },
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.touch_app,
                                      size: 30,
                                    ),
                                    label: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: Text(
                                        'Create QR Code',
                                        style: TextStyle(
                                          fontSize: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:validators/validators.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_history_qr_code.dart';

class MakeEmail extends StatefulWidget {
  const MakeEmail({Key? key}) : super(key: key);

  @override
  State<MakeEmail> createState() => _MakeEmailState();
}

class _MakeEmailState extends State<MakeEmail> {
  var valueQr = '';

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    emailController.addListener(() => setState(() {}));
    subjectController.addListener(() => setState(() {}));
    messageController.addListener(() => setState(() {}));
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
                    'Email QR Code',
                    style:
                        TextStyle(fontSize: (isScreenWidth(context)) ? 20 : 28),
                  ),
                  iconTheme: IconThemeData(
                    size: (isScreenWidth(context)) ? 24 : 30,
                    color: Colors.white,
                  ),
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
                                validator: (String? email) {
                                  if (!isEmail(email!)) {
                                    return 'Please enter a valid Email';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                                cursorWidth: 3,
                                controller: subjectController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Subject',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.subject,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                  suffixIcon: subjectController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              subjectController.clear(),
                                          icon: Icon(
                                            Icons.close,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                minLines: 1,
                                maxLines: 3,
                                cursorWidth: 3,
                                controller: messageController,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                cursorColor: Theme.of(context).primaryColor,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Message',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.message,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                  suffixIcon: messageController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              messageController.clear(),
                                          icon: Icon(
                                            Icons.close,
                                            color:
                                                Theme.of(context).primaryColor,
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
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr =
                                              'MAILTO: ${emailController.text.toString()} ?subject=${subjectController.text.toString()}&body=${messageController.text.toString()}';
                                          Get.to(
                                              () => StyleShareSaveHistoryQrCode(
                                                    valueQr: valueQr,
                                                    image: 'images/email.png',
                                                    versionValueWithLogo:
                                                        QrVersions.auto,
                                                  ));
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
                    'Email QR Code',
                    style: TextStyle(fontSize: 28),
                  ),
                  iconTheme: const IconThemeData(
                    size: 30,
                    color: Colors.white,
                  ),
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
                                validator: (String? email) {
                                  if (!isEmail(email!)) {
                                    return 'Please enter a valid Email';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                                cursorWidth: 3,
                                controller: subjectController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Subject',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.subject,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                  suffixIcon: subjectController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              subjectController.clear(),
                                          icon: Icon(
                                            Icons.close,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                minLines: 1,
                                maxLines: 3,
                                cursorWidth: 3,
                                controller: messageController,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                cursorColor: Theme.of(context).primaryColor,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Message',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.message,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                  suffixIcon: messageController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          onPressed: () =>
                                              messageController.clear(),
                                          icon: Icon(
                                            Icons.close,
                                            color:
                                                Theme.of(context).primaryColor,
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
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr =
                                              'MAILTO: ${emailController.text.toString()} ?subject=${subjectController.text.toString()}&body=${messageController.text.toString()}';
                                          Get.to(
                                              () => StyleShareSaveHistoryQrCode(
                                                    valueQr: valueQr,
                                                    image: 'images/email.png',
                                                    versionValueWithLogo:
                                                        QrVersions.auto,
                                                  ));
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

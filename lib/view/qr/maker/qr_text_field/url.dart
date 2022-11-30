import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:validators/validators.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/maker/style_share_save_favorite_qr_code.dart';

class MakeUrl extends StatefulWidget {
  const MakeUrl({Key? key}) : super(key: key);

  @override
  State<MakeUrl> createState() => _MakeUrlState();
}

class _MakeUrlState extends State<MakeUrl> {
  var valueQr = '';

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController urlController = TextEditingController();

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    urlController.addListener(() => setState(() {}));
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
                    'URL QR Code',
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
                                validator: (value) {
                                  if (!isURL(value)) {
                                    return 'Please enter a valid URL';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: urlController,
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: (isScreenWidth(context))
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: 'https://www.example.com',
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
                                            size: (isScreenWidth(context))
                                                ? 24
                                                : 30,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr =
                                              urlController.text.toString();
                                          Get.to(
                                            () => StyleShareSaveFavoriteQrCode(
                                              valueQr: valueQr,
                                              image: 'images/url.png',
                                              versionValueWithLogo:
                                                  QrVersions.auto,
                                            ),
                                          );
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
                    'URL QR Code',
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
                                validator: (value) {
                                  if (!isURL(value)) {
                                    return 'Please enter a valid URL';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorWidth: 3,
                                controller: urlController,
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.next,
                                cursorColor: Theme.of(context).primaryColor,
                                style: Theme.of(context).textTheme.titleMedium,
                                decoration: InputDecoration(
                                  hintText: 'https://www.example.com',
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
                                            size: 30,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                    if (validateKey.currentState!.validate()) {
                                      setState(
                                        () {
                                          valueQr =
                                              urlController.text.toString();
                                          Get.to(() =>
                                              StyleShareSaveFavoriteQrCode(
                                                valueQr: valueQr,
                                                image: 'images/url.png',
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
                                    padding: EdgeInsets.symmetric(vertical: 20),
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
                  ),
                ),
              ),
            ),
          );
  }
}

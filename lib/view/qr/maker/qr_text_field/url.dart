import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';
import 'package:qr_maker_app/view/qr/maker/qr_style_and_share.dart';

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
                            if (!isURL(value)) {
                              return 'Please enter a valid URL';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            hintText: 'https://www.example.com',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.link,
                              color: Theme.of(context).primaryColor,
                            ),
                            suffixIcon: urlController.text.isEmpty
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    onPressed: () => urlController.clear(),
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
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (validateKey.currentState!.validate()) {
                                setState(
                                  () {
                                    valueQr = urlController.text.toString();
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

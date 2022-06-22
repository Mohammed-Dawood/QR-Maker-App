import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_maker_app/view/qr/scan/main_qr_scan.dart';
import 'package:qr_maker_app/view/qr/maker/main_qr_make.dart';
import 'package:qr_maker_app/controller/themes_controller.dart';

class MainQr extends StatefulWidget {
  const MainQr({Key? key}) : super(key: key);

  @override
  State<MainQr> createState() => _MainQrState();
}

class _MainQrState extends State<MainQr> {
  int selectScreen = 0;
  List<String> title = [
    'Scan QR Code',
    'Make QR Code',
  ];
  List<Widget> screens = [
    const MainQrScan(),
    const MainQrMake(),
  ];

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title[selectScreen],
          style: TextStyle(
            fontSize: (isScreenWidth(context)) ? 20 : 28,
          ),
        ),
        iconTheme: IconThemeData(
          size: (isScreenWidth(context)) ? 24 : 30,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        width: (isScreenWidth(context)) ? 300 : 300,
        child: GetBuilder<ThemeController>(
          init: ThemeController(),
          builder: (ThemeController controller) => Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: controller.initValue
                    ? const AssetImage('images/background_dark.png')
                    : const AssetImage('images/background_light.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Card(
                //   child: SizedBox(
                //     width: double.infinity,
                //     height: 50,
                //     child: Center(
                //       child: Text(
                //         '${user.email}',
                //         overflow: TextOverflow.ellipsis,
                //         maxLines: 1,
                //         style: const TextStyle(
                //           color: Colors.white,
                //           fontSize: 15,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    height: 53,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Dark Theme',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GetBuilder<ThemeController>(
                          init: ThemeController(),
                          builder: (ThemeController controller) => Switch(
                            value: controller.initValue,
                            onChanged: controller.switchTheme,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: const Icon(Icons.lock_outline),
                      label: const Text(
                        ' Sign Out ',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectScreen,
        onTap: (int screenNumber) {
          setState(
            () {
              selectScreen = screenNumber;
            },
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner,
            ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Make',
          ),
        ],
      ),
      body: screens.elementAt(selectScreen),
    );
  }
}

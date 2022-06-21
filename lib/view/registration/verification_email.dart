import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_maker_app/view/qr/main_qr.dart';

class VerificationEmail extends StatefulWidget {
  const VerificationEmail({Key? key}) : super(key: key);

  @override
  State<VerificationEmail> createState() => _VerificationEmailState();
}

class _VerificationEmailState extends State<VerificationEmail> {
  Timer? timer;
  bool canResendEmail = false;
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Get.snackbar(
        'Error',
        'We have blocked all requests from this device due to unusual activity. Try again later',
        icon: const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 30,
        ),
        shouldIconPulse: false,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const MainQr()
        : Padding(
            padding: const EdgeInsets.all(30.0),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Padding(
                  padding: isScreenWidth(context)
                      ? const EdgeInsets.symmetric(horizontal: 10)
                      : const EdgeInsets.symmetric(horizontal: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'A verification email has been sent to your email.',
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed:
                                canResendEmail ? sendVerificationEmail : null,
                            icon: const Icon(Icons.email),
                            label: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                              child: Text(' Resent Email '),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                            icon: const Icon(Icons.cancel_outlined),
                            label: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                              child: Text(' Cancel '),
                            ),
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

import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qr_maker_app/main.dart';
import 'package:validators/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_maker_app/view/registration/reset_password.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  final VoidCallback onClickedSignUp;

  @override
  State<SignInWithEmail> createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  bool passwordVisibility = true;

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  Future signInWithEmail() async {
    final isValid = validateKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        '${e.message}',
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

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: validateKey,
              child: Padding(
                padding: isScreenWidth(context)
                    ? const EdgeInsets.symmetric(horizontal: 10)
                    : const EdgeInsets.symmetric(horizontal: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Card(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (!isEmail(value!)) {
                            return 'Please enter a valid Email';
                          }
                          return null;
                        },
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
                          hintText: 'Email',
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
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (isNull(value!)) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                        cursorWidth: 3,
                        controller: passController,
                        obscureText: passwordVisibility,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        cursorColor: Theme.of(context).primaryColor,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.password,
                            color: Theme.of(context).primaryColor,
                          ),
                          suffixIcon: passwordVisibility
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordVisibility = !passwordVisibility;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.visibility,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordVisibility = !passwordVisibility;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.visibility_off,
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
                        child: ElevatedButton.icon(
                          onPressed: signInWithEmail,
                          icon: const Icon(Icons.lock_open),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 18,
                            ),
                            child: Text(' Sign In '),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        text: " Don't have an account? ",
                        style: Theme.of(context).textTheme.headline4,
                        children: [
                          TextSpan(
                            text: ' Sign Up ',
                            style: Theme.of(context).textTheme.headline5,
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignUp,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Forgot Password? ',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        GestureDetector(
                          child: Text(
                            "Click here",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          onTap: () => Get.to(() => const ResetPassword()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

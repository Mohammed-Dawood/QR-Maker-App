import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qr_maker_app/main.dart';
import 'package:validators/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_maker_app/view/registration/reset_password.dart';

class SignUpWithEmail extends StatefulWidget {
  const SignUpWithEmail({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  final Function() onClickedSignIn;

  @override
  State<SignUpWithEmail> createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  bool passwordVisibility = true;

  GlobalKey<FormState> validateKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future signUp() async {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
    } catch (e) {
      // print(e);
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
                        if (isNull(value)) {
                          return 'Please enter a user name';
                        }
                        return null;
                      },
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
                        hintText: 'User Name ',
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
                        if (!isLength(value!, 8, 30)) {
                          return 'Please enter a strong password min. 8 characters';
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
                        onPressed: signUp,
                        icon: const Icon(Icons.person_add),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 18,
                          ),
                          child: Text(' Sign Up  '),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: ' Already have an account? ',
                      style: Theme.of(context).textTheme.headline4,
                      children: [
                        TextSpan(
                          text: ' Sign In ',
                          style: Theme.of(context).textTheme.headline5,
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignIn,
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
    );
  }
}

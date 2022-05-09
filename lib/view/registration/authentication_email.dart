import 'package:flutter/material.dart';
import 'package:qr_maker_app/view/registration/sign_in_with_email.dart';
import 'package:qr_maker_app/view/registration/sign_up_with_email.dart';

class AuthenticationEmail extends StatefulWidget {
  const AuthenticationEmail({Key? key}) : super(key: key);

  @override
  State<AuthenticationEmail> createState() => _AuthenticationEmailState();
}

class _AuthenticationEmailState extends State<AuthenticationEmail> {
  bool isLogin = true;

  void toggle() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? SignInWithEmail(onClickedSignUp: toggle)
        : SignUpWithEmail(onClickedSignIn: toggle);
  }
}

// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:validators/validators.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:qr_maker_app/controller/themes_controller.dart';
// import 'package:qr_maker_app/view/registration/main_sign_in.dart';

// class ResetPassword extends StatefulWidget {
//   const ResetPassword({Key? key}) : super(key: key);

//   @override
//   State<ResetPassword> createState() => _ResetPasswordState();
// }

// class _ResetPasswordState extends State<ResetPassword> {
//   GlobalKey<FormState> validateKey = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();

//   bool isScreenWidth(BuildContext context) =>
//       MediaQuery.of(context).size.width < 600;

//   @override
//   void dispose() {
//     emailController.dispose();
//     super.dispose();
//   }

//   Future resetPassword() async {
//     final isValid = validateKey.currentState!.validate();
//     if (!isValid) return;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Center(
//         child: CircularProgressIndicator(
//           backgroundColor: Colors.white,
//           color: Theme.of(context).primaryColor,
//         ),
//       ),
//     );

//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(
//         email: emailController.text.trim(),
//       );
//       Get.snackbar(
//         'Info',
//         'Password Reset Email Sent',
//         icon: const Icon(
//           Icons.info_outline,
//           color: Colors.green,
//           size: 30,
//         ),
//         shouldIconPulse: false,
//         padding: const EdgeInsets.all(15),
//         margin: const EdgeInsets.symmetric(
//           horizontal: 25,
//           vertical: 10,
//         ),
//       );
//       Navigator.of(context).popUntil((route) => route.isFirst);
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar(
//         'Error',
//         '${e.message}',
//         icon: const Icon(
//           Icons.error_outline,
//           color: Colors.red,
//           size: 30,
//         ),
//         shouldIconPulse: false,
//         padding: const EdgeInsets.all(15),
//         margin: const EdgeInsets.symmetric(
//           horizontal: 25,
//           vertical: 10,
//         ),
//       );
//       Navigator.of(context).pop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MediaQuery.of(context).orientation == Orientation.portrait
//         ? GetBuilder<ThemeController>(
//             init: ThemeController(),
//             builder: (ThemeController controller) => Container(
//               padding: const EdgeInsets.all(30),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: controller.initValue
//                       ? const AssetImage('images/background_dark.png')
//                       : const AssetImage('images/background_light.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Scaffold(
//                 backgroundColor: Colors.transparent,
//                 body: Center(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Form(
//                       key: validateKey,
//                       child: Padding(
//                         padding: isScreenWidth(context)
//                             ? const EdgeInsets.symmetric(horizontal: 10)
//                             : const EdgeInsets.symmetric(horizontal: 100),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Text(
//                                 'Receive an email to reset your password.',
//                                 style: Theme.of(context).textTheme.headline4,
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 50,
//                             ),
//                             Card(
//                               child: TextFormField(
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 validator: (value) {
//                                   if (!isEmail(value!)) {
//                                     return 'Please enter a valid Email';
//                                   }
//                                   return null;
//                                 },
//                                 cursorWidth: 3,
//                                 controller: emailController,
//                                 keyboardType: TextInputType.emailAddress,
//                                 textInputAction: TextInputAction.next,
//                                 cursorColor: Theme.of(context).primaryColor,
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 decoration: InputDecoration(
//                                   hintText: 'Email',
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   prefixIcon: Icon(
//                                     Icons.email,
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                                   border: const OutlineInputBorder(),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Theme.of(context).primaryColor,
//                                       width: 3,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Card(
//                               child: SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton.icon(
//                                   onPressed: resetPassword,
//                                   icon: const Icon(Icons.lock_reset_outlined),
//                                   label: const Padding(
//                                     padding: EdgeInsets.symmetric(
//                                       vertical: 18,
//                                     ),
//                                     child: Text(' Reset Password '),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Back to Sign In? ',
//                                   style: Theme.of(context).textTheme.headline4,
//                                 ),
//                                 GestureDetector(
//                                   child: Text(
//                                     "Click here",
//                                     style:
//                                         Theme.of(context).textTheme.headline5,
//                                   ),
//                                   onTap: () => Get.to(() => const MainSignIn()),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         : GetBuilder<ThemeController>(
//             init: ThemeController(),
//             builder: (ThemeController controller) => Container(
//               padding: const EdgeInsets.all(30),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: controller.initValue
//                       ? const AssetImage('images/background_dark.png')
//                       : const AssetImage('images/background_light.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Scaffold(
//                 backgroundColor: Colors.transparent,
//                 body: Center(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Form(
//                       key: validateKey,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 200),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Text(
//                                 'Receive an email to reset your password.',
//                                 style: Theme.of(context).textTheme.headline4,
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 50,
//                             ),
//                             Card(
//                               child: TextFormField(
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 validator: (value) {
//                                   if (!isEmail(value!)) {
//                                     return 'Please enter a valid Email';
//                                   }
//                                   return null;
//                                 },
//                                 cursorWidth: 3,
//                                 controller: emailController,
//                                 keyboardType: TextInputType.emailAddress,
//                                 textInputAction: TextInputAction.next,
//                                 cursorColor: Theme.of(context).primaryColor,
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 decoration: InputDecoration(
//                                   hintText: 'Email',
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   prefixIcon: Icon(
//                                     Icons.email,
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                                   border: const OutlineInputBorder(),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Theme.of(context).primaryColor,
//                                       width: 3,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Card(
//                               child: SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton.icon(
//                                   onPressed: resetPassword,
//                                   icon: const Icon(Icons.lock_reset_outlined),
//                                   label: const Padding(
//                                     padding: EdgeInsets.symmetric(
//                                       vertical: 18,
//                                     ),
//                                     child: Text(' Reset Password '),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Back to Sign In? ',
//                                   style: Theme.of(context).textTheme.headline4,
//                                 ),
//                                 GestureDetector(
//                                   child: Text(
//                                     "Click here",
//                                     style:
//                                         Theme.of(context).textTheme.headline5,
//                                   ),
//                                   onTap: () => Get.to(() => const MainSignIn()),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//   }
// }

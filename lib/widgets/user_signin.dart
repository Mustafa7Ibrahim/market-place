// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:market_place/auth/auth.dart';
// import 'package:market_place/widgets/width_button.dart';

// class UserSignIn extends StatefulWidget {
//   final String title;

//   const UserSignIn(this.title);
//   @override
//   _UserSignInState createState() => _UserSignInState();
// }

// class _UserSignInState extends State<UserSignIn> {
//   Auth auth = Auth();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Center(
//         child: WidthButton(
//           width: size.width,
//           onTap: () => Platform.isAndroid
//               ? auth.signInWithGoogle(context: context).whenComplete(() => setState(() {}))
//               : auth.signInWithApple(context: context).whenComplete(() => setState(() {})),
//           title: 'Sign In ',
//         ),
//       ),
//     );
//   }
// }

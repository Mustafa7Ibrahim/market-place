import 'dart:io';

import 'package:flutter/material.dart';
import 'package:market_place/auth/auth.dart';
import 'package:market_place/widgets/width_button.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fitWidth,
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: WidthButton(
              width: size.width,
              onTap: () => Platform.isAndroid
                  ? auth.signInWithGoogle(context: context)
                  : auth.signInWithApple(context: context),
              title: 'Sign In As Customer',
            ),
          ),
        ],
      ),
    );
  }
}

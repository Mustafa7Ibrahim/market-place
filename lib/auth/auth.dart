import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:market_place/constant/toast.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/screens/wrapper.dart';
import 'package:market_place/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Contains the bool value whether if the IOS support apple sign in or not
  bool supportsAppleSignIn = false;

  // get an object of the services
  final UserServices _userServices = UserServices();

  Future signInWithGoogle({@required BuildContext context}) async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      final UserCredential _userCredential =
          await firebaseAuth.signInWithCredential(authCredential);

      // if it's a new user
      final User user = _userCredential.user;

      UserModel _userModel = UserModel(
        userId: user.uid,
        userEmail: user.email,
        userImg: user.photoURL,
        userName: user.displayName,
        phoneNamber: '',
        userGender: '',
      );

      _userServices.addNewUser(_userModel);

      return user;
    } catch (e) {
      showToast(context, e.toString());

      return null;
    }
  }

  Future signOutWithGoogle(BuildContext context) async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
      showToast(context, 'Sign out Successfuly');
    } catch (e) {
      showToast(context, e.toString());
      return null;
    }
  }

  Future signInWithApple({@required BuildContext context, String type}) async {
    // an instace of shared preferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var version = iosInfo.systemVersion;

      if (version.contains('13') == true) {
        supportsAppleSignIn = true;
      }
    } else {
      showToast(context, 'Platform is not supported!');
    }

    try {
      final AuthorizationResult result = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (result.status) {
        case AuthorizationStatus.authorized:
          try {
            print("successfull sign in");
            final AppleIdCredential appleIdCredential = result.credential;

            OAuthProvider oAuthProvider = OAuthProvider("apple.com");
            final AuthCredential credential = oAuthProvider.credential(
              idToken: String.fromCharCodes(appleIdCredential.identityToken),
              accessToken: String.fromCharCodes(appleIdCredential.authorizationCode),
            );

            final UserCredential _res =
                await FirebaseAuth.instance.signInWithCredential(credential);

            final User currentUser = firebaseAuth.currentUser;

            String name =
                "${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}";
            String photoURL =
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
            await currentUser.updateProfile(displayName: name, photoURL: photoURL);

            UserModel _userModel = UserModel(
              userId: _res.user.uid,
              userEmail: _res.user.email,
              userImg: _res.user.photoURL,
              userName: _res.user.displayName,
              phoneNamber: '',
              userGender: '',
            );

            // add new user to firestore
            _userServices.addNewUser(_userModel);

            sharedPreferences.setString('user', currentUser.uid);

            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => Wrapper(),
              ),
            );
          } catch (e) {
            showToast(context, e.toString());
          }
          break;
        case AuthorizationStatus.error:
          showToast(context, 'something went wrong!');
          break;

        case AuthorizationStatus.cancelled:
          print('User cancelled');
          break;
      }
    } catch (error) {
      print("error with apple sign in");
    }
  }
}

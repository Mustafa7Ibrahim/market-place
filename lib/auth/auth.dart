import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:market_place/constant/toast.dart';
import 'package:market_place/screens/customer/customer.dart';
import 'package:market_place/screens/saller/saller.dart';
import 'package:market_place/screens/sign_in/sign_in.dart';
import 'package:market_place/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Contains the bool value whether if the IOS support apple sign in or not
  bool supportsAppleSignIn = false;

  // get an object of the services
  final UserServices _userServices = UserServices();

  Future signInWithGoogle({@required BuildContext context, String type}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      // try to sign in with google account
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn().catchError(
                (onError) => showToast(context, onError.toString()),
              );

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      final AuthResult authResult =
          await firebaseAuth.signInWithCredential(authCredential);

      // if (authResult.additionalUserInfo.isNewUser) {
      // if it's a new user
      final FirebaseUser user = authResult.user;

      // make sure that this user has a right into
      assert(user.displayName != null);
      assert(user.email != null);
      assert(user.photoUrl != null);
      assert(user.uid != null);

      // add a new user to fireStore
      if (type == 'Saller') {
        _userServices.addNewUser(
          userId: user.uid,
          userEmail: user.email,
          userImg: user.photoUrl,
          userName: user.displayName,
          phoneNumber: '',
          sallerCompanyName: '',
          userAddress: '',
          userGender: '',
        );
      } else {
        _userServices.addNewUser(
          userId: user.uid,
          userEmail: user.email,
          userImg: user.photoUrl,
          userName: user.displayName,
          phoneNumber: '',
          sallerCompanyName: '',
          userAddress: '',
          userGender: '',
        );
      }

      // make sure that the user is not an anonymous one
      assert(!user.isAnonymous);

      // make sure that the user id token is not null
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await firebaseAuth.currentUser();

      sharedPreferences.setString('user', currentUser.uid);
      sharedPreferences.setString('type', type);

      if (type == 'Saller') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Saller(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Customer(),
          ),
        );
      }

      return user;
    } catch (e) {
      showToast(context, e.toString());

      return null;
    }
  }

  signOutWithGoogle(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await googleSignIn
          .signOut()
          .catchError(
            (onError) => showToast(context, onError.toString()),
          )
          .whenComplete(
        () {
          pref.remove('user');
          pref.remove('type');
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => SignIn(),
            ),
          );
        },
      );
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

            OAuthProvider oAuthProvider =
                OAuthProvider(providerId: "apple.com");
            final AuthCredential credential = oAuthProvider.getCredential(
              idToken: String.fromCharCodes(appleIdCredential.identityToken),
              accessToken:
                  String.fromCharCodes(appleIdCredential.authorizationCode),
            );

            final AuthResult _res =
                await FirebaseAuth.instance.signInWithCredential(credential);

            FirebaseAuth.instance.currentUser().then((val) async {
              UserUpdateInfo updateUser = UserUpdateInfo();
              updateUser.displayName =
                  "${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}";
              updateUser.photoUrl =
                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
              await val.updateProfile(updateUser);
            });

            // add new user to firestore
            _userServices.addNewUser(
              userId: _res.user.uid,
              userName: _res.user.displayName,
              userEmail: _res.user.email,
              userImg: _res.user.photoUrl,
              phoneNumber: '',
              sallerCompanyName: '',
              userAddress: '',
              userGender: '',
            );

            final FirebaseUser currentUser = await firebaseAuth.currentUser();
            sharedPreferences.setString('user', currentUser.uid);
            sharedPreferences.setString('type', type);

            if (type == 'Saller') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Saller(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Customer(),
                ),
              );
            }
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

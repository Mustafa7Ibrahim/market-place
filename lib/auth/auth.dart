import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/screens/customer/customer.dart';
import 'package:market_place/screens/saller/saller.dart';
import 'package:market_place/services/customer_services.dart';
import 'package:market_place/services/saller_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // get an object of the services
  final CustomerServices _customerServices = CustomerServices();
  final SallerServices _sallerServices = SallerServices();

  Future signInWithGoogle({@required BuildContext context, String type}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      // try to sign in with google account
      final GoogleSignInAccount googleSignInAccount = await googleSignIn
          .signIn()
          .catchError(
              (onError) => Fluttertoast.showToast(msg: onError.toString()));

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      final AuthResult authResult =
          await firebaseAuth.signInWithCredential(authCredential);

      if (authResult.additionalUserInfo.isNewUser) {
        // if it's a new user
        final FirebaseUser user = authResult.user;

        // make sure that this user has a right into
        assert(user.displayName != null);
        assert(user.email != null);
        assert(user.photoUrl != null);
        assert(user.uid != null);

        // add a new user to fireStore
        if (type == 'Saller') {
          _sallerServices.addNewUser(
            user.uid,
            user.displayName,
            user.email,
            user.photoUrl,
            type,
          );
        } else {
          _customerServices.addNewUser(
            customerId: user.uid,
            customerName: user.displayName,
            email: user.email,
            type: type,
            userImg: user.photoUrl,
          );
        }

        // make sure that the user is not an anonymous one
        assert(!user.isAnonymous);

        // make sure that the user id token is not null
        assert(await user.getIdToken() != null);

        final FirebaseUser currentUser = await firebaseAuth.currentUser();
        sharedPreferences.setString('user', currentUser.displayName);
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
      } else {
        var userType;
        // if it's an exesting user
        final FirebaseUser userAuth = authResult.user;
        // make sure that this user has a right into
        assert(userAuth.displayName != null);
        assert(userAuth.email != null);
        assert(userAuth.photoUrl != null);
        assert(userAuth.uid != null);
        // make sure that the user is not an anonymous one
        assert(!userAuth.isAnonymous);
        // make sure that the user id token is not null
        assert(await userAuth.getIdToken() != null);

        final FirebaseUser currentUser = await firebaseAuth.currentUser();

        userCollection.document(userAuth.uid).get().then(
          (DocumentSnapshot snapshot) {
            userType = snapshot.data['type'];
          },
        ).whenComplete(() {
          if (userType == type) {
            sharedPreferences.setString('user', currentUser.displayName);
            sharedPreferences.setString('type', userType);
            if (userType == 'Saller') {
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
          } else {
            Fluttertoast.showToast(
              msg: 'You are note a $type please sign in as a $userType',
            );
          }
        });

        return userAuth;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  signOutWithGoogle(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await googleSignIn
          .signOut()
          .catchError(
              (onError) => Fluttertoast.showToast(msg: onError.toString()))
          .whenComplete(
        () {
          pref.remove('user');
          pref.remove('type');
          Navigator.pushReplacementNamed(context, '/');
        },
      );
      Fluttertoast.showToast(msg: 'Sign out Successfuly');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }
}

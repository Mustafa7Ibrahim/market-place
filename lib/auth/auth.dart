import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:market_place/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final User _user = User();

  Future signInWithGoogle({BuildContext context, String type}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      // try to sign in with google account
      final GoogleSignInAccount googleSignInAccount = await googleSignIn
          .signIn()
          .catchError((onError) => showSnakBar(onError.toString(), context));

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      final AuthResult authResult =
          await firebaseAuth.signInWithCredential(authCredential);
      final FirebaseUser user = authResult.user;

      // make sure that this user has a right into
      assert(user.displayName != null);
      assert(user.email != null);
      assert(user.photoUrl != null);
      assert(user.uid != null);

      // add a new user to fireStore
      _user.addNewUser(user.uid, user.uid, user.email, user.photoUrl, type);

      // make sure that the user is not an anonymous one
      assert(!user.isAnonymous);

      // make sure that the user id token is not null
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();

      userCollection.document(user.uid).snapshots().map(_user.getCurrentUser);

      sharedPreferences.setString('user', currentUser.displayName);
      sharedPreferences.setString('type', type);

      if (type == 'Saller') {
        Navigator.pushReplacementNamed(context, '/saller');
      } else {
        Navigator.pushReplacementNamed(context, '/customer');
      }
      return user;
    } catch (e) {
      showSnakBar(e.toString(), context);
      return null;
    }
  }

  Future signOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await googleSignIn
          .signOut()
          .catchError((onError) => showSnakBar(onError.toString(), context))
          .whenComplete(
        () {
          sharedPreferences.remove('user');
          sharedPreferences.remove('type');
          Navigator.pushReplacementNamed(context, '/');
        },
      );

      showSnakBar('Sign out Successfuly', context);
    } catch (e) {
      showSnakBar(e.toString(), context);
      return null;
    }
  }

  void showSnakBar(String msg, BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 7),
      ),
    );
  }
}

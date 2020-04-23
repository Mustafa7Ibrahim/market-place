import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:market_place/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User> signInWithGoogle() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {} catch (e) {}
  }
}

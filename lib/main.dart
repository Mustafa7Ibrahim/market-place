import 'package:market_place/screens/sign_in/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'screens/customer/customer.dart';
import 'screens/saller/saller.dart';
import 'constant/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();

  var currentUserId = pref.getString('user');
  var type = pref.getString('type');

  runApp(Home(currentUser: currentUserId, type: type));
}

class Home extends StatefulWidget {
  final currentUser;
  final type;

  Home({this.currentUser, this.type});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market Place',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: widget.currentUser == null
          ? SignIn()
          : widget.type == 'Customer' ? Customer() : Saller(),
    );
  }
}

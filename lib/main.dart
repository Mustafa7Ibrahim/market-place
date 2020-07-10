import 'package:market_place/screens/sign_in/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'constant/theme_changer.dart';
import 'screens/customer/customer.dart';
import 'screens/saller/saller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();

  var currentUserId = pref.getString('user');
  var type = pref.getString('type');
  var darkTheme = pref.getBool('DarkTheme');

  runApp(
    ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(
        themeData: darkTheme == null || darkTheme == false
            ? ThemeChanger.lightTheme
            : ThemeChanger.darkTheme,
      ),
      child: Home(
        currentUser: currentUserId,
        type: type,
        darkTheme: darkTheme,
      ),
    ),
  );
}

class Home extends StatefulWidget {
  final currentUser;
  final type;
  final darkTheme;

  Home({this.currentUser, this.type, this.darkTheme});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Market Place',
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: widget.currentUser == null
          ? SignIn()
          : widget.type == 'Customer' ? Customer() : Saller(),
    );
  }
}

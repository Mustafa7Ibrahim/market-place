import 'package:market_place/screens/sign_in/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'constant/theme_changer.dart';
import 'screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var currentUserId = pref.getString('user');
  var darkTheme = pref.getBool('DarkTheme');
  runApp(
    ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(
        themeData: darkTheme == null || darkTheme == false
            ? ThemeChanger.lightTheme
            : ThemeChanger.darkTheme,
      ),
      child: App(currentUser: currentUserId, darkTheme: darkTheme),
    ),
  );
}

class App extends StatelessWidget {
  final currentUser;
  final darkTheme;

  App({this.currentUser, this.darkTheme});
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Market Place',
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: currentUser == null ? SignIn() : Wrapper(),
    );
  }
}

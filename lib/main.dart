import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'constant/theme_changer.dart';
import 'screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  SharedPreferences pref = await SharedPreferences.getInstance();
  var darkTheme = pref.getBool('DarkTheme');
  runApp(
    ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(
        themeData: darkTheme == null || darkTheme == false
            ? ThemeChanger.lightTheme
            : ThemeChanger.darkTheme,
      ),
      child: App(darkTheme),
    ),
  );
}

class App extends StatelessWidget {
  final darkTheme;

  App(this.darkTheme);
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Market Place',
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: Wrapper(),
    );
  }
}

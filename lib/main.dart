import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:market_place/screens/wrapper.dart';
import 'package:market_place/services/sp_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'constant/theme_changer.dart';

void main() {
  bool darkTheme;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SPServices().getcurrentTheme().then((currentTheme) => darkTheme = currentTheme);
  runApp(App(darkTheme: darkTheme));
}

class App extends StatelessWidget {
  App({this.darkTheme});
  final bool darkTheme;

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeChanger(
        themeData: darkTheme == null || darkTheme == false
            ? ThemeChanger.lightTheme
            : ThemeChanger.darkTheme,
      ),
      child: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          return Consumer<ThemeChanger>(
            builder: (context, theme, child) {
              return MaterialApp(
                title: 'Market Place',
                debugShowCheckedModeBanner: false,
                theme: theme.getTheme(),
                home: snapshot.hasError
                    ? Scaffold(body: Center(child: Text('Something went wrong!')))
                    : snapshot.connectionState == ConnectionState.done
                        ? Wrapper()
                        : Scaffold(body: Center(child: CircularProgressIndicator())),
              );
            },
          );
        },
      ),
    );
  }
}

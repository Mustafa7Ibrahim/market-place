import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:market_place/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant/theme_changer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool darkTheme = pref.getBool('DarkTheme');

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeChanger(
        themeData: darkTheme == null || false ? ThemeChanger.lightTheme : ThemeChanger.darkTheme,
      ),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context);
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Market Place',
          debugShowCheckedModeBanner: false,
          theme: currentTheme.getTheme(),
          home: snapshot.hasError
              ? Scaffold(body: Center(child: Text('Something went wrong!')))
              : snapshot.connectionState == ConnectionState.done
                  ? Wrapper()
                  : Scaffold(body: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}

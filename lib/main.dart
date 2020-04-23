import 'package:flutter/material.dart';
import 'package:market_place/screens/sign_in/sign_in.dart';
import 'package:market_place/screens/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context)=> Wrapper(),
        'sign_in': (context) => SignIn(),
      },
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

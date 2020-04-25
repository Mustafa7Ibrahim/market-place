import 'package:flutter/material.dart';
import 'package:market_place/constant/theme.dart';
import 'package:market_place/screens/customer/customer.dart';
import 'package:market_place/screens/saller/saller.dart';
import 'package:market_place/screens/sign_in/sign_in.dart';
import 'package:market_place/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var user = pref.getString('user');
  var type = pref.getString('type');
  runApp(
    MultiProvider(
      providers: [
        StreamProvider<User>.value(value: User().getUser),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        initialRoute:
            user == null ? '/' : type == 'Customer' ? '/customer' : '/saller',
        routes: {
          '/': (context) => Wrapper(),
          '/sign_in': (context) => SignIn(),
          '/saller': (context) => Saller(),
          '/customer': (context) => Customer(),
        },
      ),
    ),
  );
}

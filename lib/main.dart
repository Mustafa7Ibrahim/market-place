import 'package:market_place/services/product_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/customer/customer.dart';
import 'screens/saller/saller.dart';
import 'screens/wrapper.dart';
import 'constant/theme.dart';
import 'models/product.dart';
import 'models/saller_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();

  var currentUser = pref.getString('user');
  var type = pref.getString('type');
  runApp(Home(
    currentUser: currentUser,
    type: type,
  ));
}

class Home extends StatefulWidget {
  final firebaseUser;
  final currentUser;
  final type;
  Home({this.firebaseUser, this.currentUser, this.type});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SallerUser user = SallerUser();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Product>>.value(
          value: ProductServices().productListstrm,
        ),
      ],
      child: MaterialApp(
        title: 'makr',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: widget.currentUser == null
            ? Wrapper()
            : widget.type == 'Customer' ? Customer() : Saller(),
      ),
    );
  }
}

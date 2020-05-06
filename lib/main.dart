import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/saller/saller_products/saller_products.dart';
import 'screens/customer/customer.dart';
import 'screens/sign_in/sign_in.dart';
import 'screens/saller/saller.dart';
import 'screens/wrapper.dart';
import 'constant/theme.dart';
import 'models/product.dart';
import 'models/user.dart';

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
  User user = User();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Product>>.value(value: Product().productListstrm),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        initialRoute: widget.currentUser == null
            ? '/'
            : widget.type == 'Customer' ? '/customer' : '/saller',
        routes: {
          '/': (context) => Wrapper(),
          '/sign_in': (context) => SignIn(),
          '/saller': (context) => Saller(),
          '/customer': (context) => Customer(),
          '/saller_products': (context) => SallerProducts(),
        },
      ),
    );
  }
}

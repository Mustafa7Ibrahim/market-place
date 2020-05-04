import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/constant/theme.dart';
import 'package:market_place/screens/customer/customer.dart';
import 'package:market_place/screens/saller/add_new_product/add_new_product.dart';
import 'package:market_place/screens/saller/saller.dart';
import 'package:market_place/screens/saller/saller_products/saller_products.dart';
import 'package:market_place/screens/sign_in/sign_in.dart';
import 'package:market_place/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/product.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  User user = User();
  var currentUser = pref.getString('user');
  var type = pref.getString('type');
  runApp(
    MultiProvider(
      providers: [
        StreamProvider<List<Product>>.value(value: Product().productListstrm),
        StreamProvider<User>.value(
          value: userCollection
              .document(firebaseUser?.uid ?? '')
              .snapshots()
              .map(user.getCurrentUser),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        initialRoute: currentUser == null
            ? '/'
            : type == 'Customer' ? '/customer' : '/saller',
        routes: {
          '/': (context) => Wrapper(),
          '/sign_in': (context) => SignIn(),
          '/saller': (context) => Saller(),
          '/customer': (context) => Customer(),
          '/saller_products': (context) => SallerProducts(),
          '/add_new_product': (context) => AddNewProduct(),
        },
      ),
    ),
  );
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/auth/auth.dart';
import 'package:market_place/screens/my_account/my_account.dart';
import 'package:market_place/screens/saller/add_new_product/add_new_product.dart';
import 'package:market_place/screens/saller/saller_products/saller_products.dart';

class Saller extends StatefulWidget {
  @override
  _SallerState createState() => _SallerState();
}

class _SallerState extends State<Saller> {
  Auth auth = Auth();
  var currentIndex;
  FirebaseUser thisUser;

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  void changePage(int index) {
    setState(() => currentIndex = index);
  }

  List<Widget> _screenIndex = <Widget>[
    SallerProducts(),
    MyAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'To add a new Product',
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => AddNewProduct(product: null),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
        unselectedIconTheme: IconThemeData(color: Colors.black87),
        unselectedLabelStyle: TextStyle(color: Colors.black87),
        currentIndex: currentIndex,
        onTap: changePage,
        elevation: 0.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('My Account'),
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: _screenIndex.elementAt(currentIndex),
    );
  }
}

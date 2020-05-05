import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/auth/auth.dart';
import 'package:market_place/screens/saller/add_new_product/add_new_product.dart';
import 'package:market_place/screens/saller/profile/profile.dart';
import 'package:market_place/screens/saller/saller_products/saller_products.dart';

class Saller extends StatefulWidget {
  @override
  _SallerState createState() => _SallerState();
}

class _SallerState extends State<Saller> {
  Auth auth = Auth();
  var currentIndex;

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
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'To add a new Product',
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddNewProduct(
              proImages: null,
              proName: null,
              proQuantity: null,
              proType: null,
              proDes: null,
              proSpecif: null,
              proPrice: null,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Colors.deepPurpleAccent),
        selectedLabelStyle: TextStyle(color: Colors.deepPurpleAccent),
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
            title: Text('Profile'),
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: _screenIndex.elementAt(currentIndex),
    );
  }
}

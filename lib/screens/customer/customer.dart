import 'package:flutter/material.dart';
import 'package:market_place/screens/customer/cart/cart.dart';
import 'package:market_place/screens/customer/categories/categories.dart';
import 'package:market_place/screens/my_account/my_account.dart';

import 'home/home.dart';

class Customer extends StatefulWidget {
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  List<Widget> _screenIndex = <Widget>[
    Home(),
    Categories(),
    Cart(),
    MyAccount(),
  ];

  int currentIndex;

  void changePage(int index) {
    setState(() => currentIndex = index);
  }

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: changePage,
        elevation: 0.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Categories'),
            icon: Icon(
              Icons.category,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('Cart'),
            icon: Icon(
              Icons.shopping_cart,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('MyAccount'),
            icon: Icon(
              Icons.person_outline,
            ),
          ),
        ],
      ),
      body: _screenIndex.elementAt(currentIndex),
    );
  }
}

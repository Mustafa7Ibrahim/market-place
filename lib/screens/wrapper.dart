import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/screens/categories/categories.dart';
import 'package:market_place/screens/home/home.dart';
import 'package:market_place/screens/my_account/my_account.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  List<Widget> _screenIndex = <Widget>[
    Home(),
    Categories(),
    MyAccount(),
  ];

  int currentIndex = 0;

  void changePage(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).appBarTheme.color,
        selectedItemColor: Theme.of(context).primaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: changePage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Categories', icon: Icon(Icons.category_rounded)),
          BottomNavigationBarItem(label: 'MyAccount', icon: Icon(Icons.person)),
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            fillColor: Theme.of(context).colorScheme.surface,
            child: child,
          );
        },
        child: _screenIndex[currentIndex],
      ),
    );
  }
}

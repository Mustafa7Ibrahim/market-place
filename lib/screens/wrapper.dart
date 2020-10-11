import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/screens/cart/cart.dart';
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
      // appBar: CustomAppBar(),
      // bottomNavigationBar: CupertinoTabBar(
      //   backgroundColor: Theme.of(context).appBarTheme.color,
      //   activeColor: Theme.of(context).cursorColor,
      //   border: Border.symmetric(horizontal: BorderSide.none),
      //   currentIndex: currentIndex,
      //   onTap: changePage,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
      //     BottomNavigationBarItem(label: 'Categories', icon: Icon(Icons.category)),
      //     BottomNavigationBarItem(label: 'Cart', icon: Icon(Icons.shopping_cart)),
      //     BottomNavigationBarItem(label: 'MyAccount', icon: Icon(Icons.person_outline)),
      //   ],
      // ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: IndexedStack(children: _screenIndex, index: currentIndex),
      ),
    );
  }
}

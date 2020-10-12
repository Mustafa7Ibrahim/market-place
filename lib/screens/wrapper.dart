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
    MyAccount(),
  ];

  int currentIndex = 0;

  void changePage(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.shopping_bag_outlined),
        title: Text('Market Place'),
        titleSpacing: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.search_rounded), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => Cart()),
            ),
          ),
          IconButton(
            icon: Icon(Icons.dehaze_rounded),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                barrierColor: Colors.black.withOpacity(0.8),
                elevation: 0.9,
                isScrollControlled: true,
                clipBehavior: Clip.antiAlias,
                enableDrag: true,
                isDismissible: true,
                builder: (context) {
                  return Container(
                    margin: EdgeInsets.all(24.0),
                    child: MyAccount(),
                  );
                },
              );
            },
          ),
        ],
      ),
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
          BottomNavigationBarItem(label: 'Categories', icon: Icon(Icons.category)),
          BottomNavigationBarItem(label: 'MyAccount', icon: Icon(Icons.person_outline)),
        ],
      ),
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

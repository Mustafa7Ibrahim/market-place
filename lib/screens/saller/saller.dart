import 'package:flutter/material.dart';
import 'package:market_place/auth/auth.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        elevation: 0.0,
        title: Text('Saller'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'To add a new Product',
        child: Icon(Icons.add),
        onPressed: () {},
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
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Seller'),
            onPressed: () => auth.signOutWithGoogle(context),
          ),
        ),
      ),
    );
  }
}

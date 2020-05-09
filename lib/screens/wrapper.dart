import 'package:flutter/material.dart';
import 'package:market_place/screens/sign_in/sign_in.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/des.png',
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: height * 0.2),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            width: width,
            height: 64,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
                side: BorderSide(
                  color: Color.fromRGBO(84, 52, 214, 1),
                  width: 2.0,
                ),
              ),
              child: Text(
                'I\'m a Saller',
                style: TextStyle(color: Color.fromRGBO(84, 52, 214, 1)),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(type: 'Saller'),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            width: width,
            height: 64,
            child: FlatButton(
              color: Color.fromRGBO(84, 52, 214, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: Text(
                'I\'m a Customer',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(type: 'Customer'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

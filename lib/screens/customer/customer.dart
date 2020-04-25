import 'package:flutter/material.dart';
import 'package:market_place/auth/auth.dart';

class Customer extends StatefulWidget {
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer',
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text('customer'),
              onPressed: () => auth.signOutWithGoogle(context),
            ),
          ),
        ],
      ),
    );
  }
}

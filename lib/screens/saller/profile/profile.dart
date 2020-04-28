import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/user.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Profile'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [shadow],
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: TextFormField(
              initialValue: currentUser.companyName,
              decoration: inputDecoration.copyWith(
                hintText: 'Edit Your Company Name..',
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [shadow],
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: TextFormField(
              initialValue: currentUser.name,
              decoration: inputDecoration,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [shadow],
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: TextFormField(
              initialValue: currentUser.email,
              decoration: inputDecoration,
            ),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
            color: Color.fromRGBO(84, 52, 214, 1),
            child: Text('Update'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/auth/auth.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/screens/profile.dart/edit_profile.dart';
import 'package:market_place/services/user_services.dart';
import 'package:market_place/widgets/address.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:market_place/widgets/my_acc_info.dart';
import 'package:market_place/widgets/width_button.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Auth auth = Auth();
  String id;

  loadUser() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    setState(() => id = firebaseUser.uid);
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<UserModel>(
      stream: UserServices().currentUserData,
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Loading(
                color: Theme.of(context).primaryColor,
                height: size.height,
                width: size.width,
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Market Place',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  centerTitle: true,
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => EditProfile(),
                        ),
                      ),
                      child: Text('EDIT'),
                    )
                  ],
                ),
                bottomNavigationBar: WidthButton(
                  width: size.width,
                  onTap: () => auth.signOutWithGoogle(context),
                  title: 'SignOut',
                ),
                body: ListView(
                  children: <Widget>[
                    SizedBox(height: 12.0),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 26.0),
                      child: Text(
                        'My Account',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    MyAccountInfo(
                      customerName: snapshot.data.sallerCompanyName,
                      email: snapshot.data.userEmail,
                      gender: snapshot.data.userGender,
                      size: size,
                    ),
                    SizedBox(height: 12.0),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 26.0),
                      child: Text(
                        'Address',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6),
                            ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Address(
                      size: size,
                      name: snapshot.data.userName,
                      address: snapshot.data.userAddress,
                      phoneNumber: snapshot.data.phoneNamber,
                    ),
                  ],
                ),
              );
      },
    );
  }
}

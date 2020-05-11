import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/customer_user.dart';
import 'package:market_place/models/saller_user.dart';
import 'package:market_place/widgets/address.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:market_place/widgets/my_acc_info.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  CustomerUser _customerUser = CustomerUser();
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
    return StreamBuilder<CustomerUser>(
      stream: userCollection
          .document(id)
          .snapshots()
          .map(_customerUser.getCurrentUser),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Loading(color: Theme.of(context).primaryColor)
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Market Place',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  centerTitle: true,
                ),
                body: ListView(
                  children: <Widget>[
                    SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 6.0,
                      ),
                      child: Text(
                        'My Account',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6),
                            ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    MyAccountInfo(
                      customerName: snapshot.data.customerName,
                      email: snapshot.data.email,
                      gender: snapshot.data.gender,
                      size: size,
                    ),
                    SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 6.0,
                      ),
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
                      name: snapshot.data.customerName,
                      address: snapshot.data.address,
                      phoneNumber: snapshot.data.phoneNamber,
                    ),
                  ],
                ),
              );
      },
    );
  }
}

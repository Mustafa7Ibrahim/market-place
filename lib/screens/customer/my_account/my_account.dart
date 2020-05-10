import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/customer_user.dart';
import 'package:market_place/models/saller_user.dart';
import 'package:market_place/widgets/address.dart';
import 'package:market_place/widgets/loading.dart';

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
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        boxShadow: [shadow],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${snapshot.data.customerName} \n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                TextSpan(
                                  text: snapshot.data.email,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
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

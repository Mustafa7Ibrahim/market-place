import 'package:flutter/material.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/services/user_services.dart';
import 'package:market_place/widgets/user_signin.dart';
import 'components/body.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<UserModel>(
        stream: UserServices().currentUserData,
        builder: (context, snapshot) {
          return snapshot.hasError
              ? Center(child: Text(snapshot.error))
              : snapshot.data == null
                  ? UserSignIn('title')
                  : snapshot.hasData
                      ? Body(user: snapshot.data)
                      : CircularProgressIndicator();
        },
      ),
    );
  }
}

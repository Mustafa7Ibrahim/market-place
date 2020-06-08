import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/auth/auth.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/screens/my_account/edit_profile.dart';
import 'package:market_place/widgets/image_network.dart';
import 'package:market_place/widgets/info_row.dart';
import 'package:market_place/widgets/row_edit.dart';
import 'package:market_place/widgets/width_button.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: appBar(context, user),
      bottomNavigationBar: WidthButton(
        width: size.width,
        onTap: () => auth.signOutWithGoogle(context),
        title: 'Sign Out',
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 12.0),
          titleLine(context, 'My Account'),
          SizedBox(height: 12.0),
          personalInfo(user, context, size),
          SizedBox(height: 12.0),
          titleLine(context, 'Address'),
          SizedBox(height: 12.0),
          addressInfo(size, user),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context, UserModel user) {
    return AppBar(
      title: Text(
        'My Account',
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
              builder: (context) => EditMyAccount(user),
            ),
          ),
          child: Text('EDIT'),
        )
      ],
    );
  }

  Container titleLine(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 26.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.6),
            ),
      ),
    );
  }

  Container addressInfo(Size size, UserModel user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        boxShadow: [shadow],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: <Widget>[
          RowEdit(
            iconRow: Icons.person_pin_circle,
            onTap: () {},
            title: 'Home',
          ),
          InfoRow(
            size: size,
            title: 'Name',
            info: user?.userName ?? '',
          ),
          InfoRow(
            size: size,
            title: 'Address',
            info: user?.userAddress ?? '',
          ),
          InfoRow(
            size: size,
            title: 'Mobile Number',
            info: user?.phoneNamber ?? '',
          )
        ],
      ),
    );
  }

  Container personalInfo(UserModel user, BuildContext context, Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        boxShadow: [shadow],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RowEdit(
            title: 'Personal Information',
            iconRow: Icons.person,
            onTap: () {},
          ),
          SizedBox(height: 12.0),
          Row(
            children: <Widget>[
              ImageNetwork(
                image: user?.userImg ??
                    'https://images.unsplash.com/photo-1532276269954-64188308dcb3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
                width: size.width / 8,
                height: size.width / 8,
              ),
              SizedBox(width: 6.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${user?.userName?? ""}\n' ,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: user?.userEmail ?? '',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          InfoRow(
            size: size,
            title: 'Gender',
            info: user?.userGender ?? 'Gender',
          )
        ],
      ),
    );
  }
}

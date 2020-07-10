import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/auth/auth.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/constant/theme_changer.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/screens/my_account/edit_profile.dart';
import 'package:market_place/services/user_services.dart';
import 'package:market_place/widgets/image_network.dart';
import 'package:market_place/widgets/info_row.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:market_place/widgets/row_edit.dart';
import 'package:market_place/widgets/width_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Auth auth = Auth();
  var currentUserId;
  bool isSwitched = false;
  String switchText = 'DarkTheme';

  @override
  void initState() {
    getCurrentUserId();
    getCurrentTheme();
    super.initState();
  }

  getCurrentUserId() async {
    // get the current user id if the user is alredy loged in
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() => currentUserId = sharedPreferences.getString('user'));
    // return the current user id
    return currentUserId;
  }

  getCurrentTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final darkTheme = sharedPreferences.getBool('DarkTheme');
    if (darkTheme == false || darkTheme == null)
      setState(() => isSwitched = false);
    else
      setState(() => isSwitched = true);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var changeTheme = Provider.of<ThemeChanger>(context, listen: false);
    void switchChange(bool value) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (isSwitched == false) {
        changeTheme.setTheme(ThemeChanger.darkTheme);
        setState(() {
          isSwitched = true;
          switchText = 'Light Theme';
          pref.setBool('DarkTheme', true);
        });
      } else {
        changeTheme.setTheme(ThemeChanger.lightTheme);
        setState(() {
          isSwitched = false;
          switchText = 'Dark Theme';
          pref.setBool('DarkTheme', false);
        });
      }
    }

    return StreamBuilder<UserModel>(
      stream: userCollection
          .document(currentUserId)
          .snapshots()
          .map(UserServices().getUserData),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: appBar(context, user),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
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
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Dark Theme'),
                          Switch(
                            activeColor: Theme.of(context).accentColor,
                            activeTrackColor: Theme.of(context).accentColor,
                            value: isSwitched,
                            onChanged: (value) => switchChange(value),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: WidthButton(
                      width: size.width,
                      onTap: () => auth.signOutWithGoogle(context),
                      title: 'Sign Out',
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error),
            );
          } else {
            return Loading(color: Theme.of(context).accentColor);
          }
        } else {
          return Container();
        }
        // else if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Center(child: Text('wait..'));
        // }
      },
    );
  }

  AppBar appBar(BuildContext context, UserModel user) {
    return AppBar(
      title: Text(
        'My Account',
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Theme.of(context).accentColor),
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
              color: Theme.of(context).iconTheme.color,
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
        color: Theme.of(context).appBarTheme.color,
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
        color: Theme.of(context).appBarTheme.color,
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
              SizedBox(
                height: size.width * 0.13,
                width: size.width * 0.13,
                child: ImageNetwork(
                  image: user?.userImg ??
                      'https://images.unsplash.com/photo-1532276269954-64188308dcb3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
                ),
              ),
              SizedBox(width: 6.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${user?.userName ?? ""}\n',
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

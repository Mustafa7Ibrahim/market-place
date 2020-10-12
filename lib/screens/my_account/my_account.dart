import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/auth/auth.dart';
import 'package:market_place/constant/theme_changer.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/services/user_services.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:market_place/widgets/user_signin.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final User currentUser = FirebaseAuth.instance.currentUser;
  Auth auth = Auth();
  bool isSwitched = false;
  String switchText = 'DarkTheme';

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
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

    return currentUser == null
        ? UserSignIn('Account')
        : Scaffold(
            body: StreamBuilder<UserModel>(
              stream: UserServices().currentUserData,
              builder: (context, snapshot) {
                final user = snapshot.data;
                if (snapshot.hasData) {
                  return buildProfileWhenHasData(context, user, switchChange);
                }

                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error));
                }

                return Loading(color: Theme.of(context).accentColor);
              },
            ),
          );
  }

  buildProfileWhenHasData(BuildContext context, UserModel user, void switchChange(bool value)) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            width: double.infinity,
            color: Theme.of(context).appBarTheme.color,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.userName}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Text('${user.userEmail}'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 2.0),
                  child: Text(
                    'My Account',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                TypeOne(
                  icon: Icons.dashboard_outlined,
                  title: 'Orders',
                  onTap: () {},
                ),
                SizedBox(height: 6.0),
                TypeOne(
                  icon: Icons.favorite_border_rounded,
                  title: 'WishList',
                  onTap: () {},
                ),
                SizedBox(height: 6.0),
                TypeOne(
                  icon: Icons.edit_rounded,
                  title: 'Details',
                  onTap: () {},
                ),
                SizedBox(height: 6.0),
                TypeOne(
                  icon: Icons.not_listed_location_outlined,
                  title: 'Address book',
                  onTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 2.0),
                  child: Text(
                    'Settings',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                HoverEffect(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text('Dark Theme'),
                      ),
                      Switch(
                        activeColor: Theme.of(context).accentColor,
                        activeTrackColor: Theme.of(context).accentColor,
                        value: isSwitched,
                        onChanged: (value) => switchChange(value),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.0),
                TypeOne(
                  icon: Icons.language,
                  title: 'Language',
                  onTap: () {},
                ),
                SizedBox(height: 6.0),
                TypeOne(
                  icon: Icons.admin_panel_settings_outlined,
                  title: 'Sign out',
                  onTap: () => auth.signOutWithGoogle(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TypeOne extends StatelessWidget {
  final Function onTap;
  final String title;
  final IconData icon;

  const TypeOne({this.onTap, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return HoverEffect(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 6.0),
            Text(title),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}

class HoverEffect extends StatelessWidget {
  const HoverEffect({@required this.onTap, @required this.child});

  final Function onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}

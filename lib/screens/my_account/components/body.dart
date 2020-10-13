import 'package:flutter/material.dart';
import 'package:market_place/auth/auth.dart';
import 'package:market_place/constant/theme_changer.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/widgets/hover_effect.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu_button.dart';

class Body extends StatefulWidget {
  Body({@required this.user});
  final UserModel user;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Auth auth = Auth();
  bool isSwitched = false;

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

  void switchChange(var theme, bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (value == true) {
      theme.setTheme(ThemeChanger.darkTheme);
      setState(() {
        isSwitched = value;
        pref.setBool('DarkTheme', true);
      });
    } else {
      theme.setTheme(ThemeChanger.lightTheme);
      setState(() {
        isSwitched = value;
        pref.setBool('DarkTheme', false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 12.0, right: 12.0, left: 12.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    widget.user.userImg,
                    height: size.width * 0.16,
                    width: size.width * 0.16,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '${widget.user.userName}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Text('${widget.user.userEmail}'),
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
                MenuButton(
                  icon: Icons.dashboard_outlined,
                  title: 'Orders',
                  onTap: () {},
                ),
                SizedBox(height: 6.0),
                MenuButton(
                  icon: Icons.favorite_border_rounded,
                  title: 'WishList',
                  onTap: () {},
                ),
                SizedBox(height: 6.0),
                MenuButton(
                  icon: Icons.edit_rounded,
                  title: 'Details',
                  onTap: () {},
                ),
                SizedBox(height: 6.0),
                MenuButton(
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
                      Consumer<ThemeChanger>(
                        builder: (context, theme, child) {
                          return Switch(
                            activeColor: Theme.of(context).primaryColor,
                            activeTrackColor: Theme.of(context).primaryColor,
                            value: isSwitched,
                            onChanged: (value) => switchChange(theme, value),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.0),
                MenuButton(
                  icon: Icons.language,
                  title: 'Language',
                  onTap: () {},
                ),
                SizedBox(height: 6.0),
                MenuButton(
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

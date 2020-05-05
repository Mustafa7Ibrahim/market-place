import 'package:flutter/material.dart';
import 'package:market_place/models/user.dart';
import 'package:market_place/widgets/edit_feild.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:market_place/widgets/width_button.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user = User();

  String name;
  String companyName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentUser = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Profile'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: currentUser == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                EditFeild(
                  hint: 'Edit Your Company Name..',
                  enable: true,
                  currentValue: currentUser.companyName == null
                      ? companyName
                      : currentUser.companyName,
                  max: 1,
                ),
                EditFeild(
                  hint: 'Name',
                  enable: true,
                  currentValue: currentUser.name,
                  max: 1,
                ),
                EditFeild(
                  hint: 'Email',
                  enable: false,
                  currentValue: currentUser.email,
                  max: 1,
                ),
                WidthButton(
                  title: 'Update',
                  width: size.width,
                  onTap: () => user.updateUser(
                    currentUser.id,
                    name,
                    companyName,
                  ),
                )
              ],
            )
          : Loading(color: Theme.of(context).primaryColor),
    );
  }
}

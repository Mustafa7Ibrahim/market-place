import 'package:flutter/material.dart';
import 'package:market_place/auth/auth.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/services/user_services.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:market_place/widgets/width_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserServices _userServices = UserServices();
  final Auth _auth = Auth();
  // a global key for the stat of the form
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _email;
  String _sallerCompanyName;
  String _address;
  String _phoneNumber;

  var _radioGender;
  bool loading;

  String currentUserId;

  @override
  void initState() {
    loading = false;
    getCurrentUserId();
    // _radioGender = widget?.user?.userGender ?? '';
    super.initState();
  }

  getCurrentUserId() async {
    // get the current user id if the user is alredy loged in
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    currentUserId = sharedPreferences.getString('user');
    print(currentUserId);
    // return the current user id
    return currentUserId;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<UserModel>(
      stream: userCollection
          .document(currentUserId)
          .snapshots()
          .map(_userServices.getUserData),
      builder: (context, snapshot) {
        final user = snapshot.data;
        return Scaffold(
          appBar: appBar(context),
          body: !snapshot.hasData
              ? Loading(
                  color: Theme.of(context).primaryColor,
                  height: size.height,
                  width: size.width,
                )
              : ListView(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            decoration: textFaildDecoration,
                            child: TextFormField(
                              decoration: inputDecoration.copyWith(
                                hintText: 'Your Name',
                              ),
                              validator: (value) =>
                                  value.isEmpty ? 'Enter Your Name..' : null,
                              initialValue: user.userName ?? '',
                              onChanged: (value) => _name = value,
                              cursorColor: Theme.of(context).primaryColor,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            decoration: textFaildDecoration,
                            child: TextFormField(
                              decoration: inputDecoration.copyWith(
                                hintText: 'Your Email',
                              ),
                              validator: (value) =>
                                  value.isEmpty ? 'Enter Your Email..' : null,
                              initialValue: user.userEmail ?? '',
                              onChanged: (value) => _email = value,
                              cursorColor: Theme.of(context).primaryColor,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            decoration: textFaildDecoration,
                            child: TextFormField(
                              decoration: inputDecoration.copyWith(
                                hintText: 'Address',
                              ),
                              validator: (value) =>
                                  value.isEmpty ? 'Enter Your Address..' : null,
                              initialValue: user.userAddress ?? '',
                              onChanged: (value) => _address = value,
                              cursorColor: Theme.of(context).primaryColor,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            decoration: textFaildDecoration,
                            child: TextFormField(
                              decoration: inputDecoration.copyWith(
                                hintText: 'Phone Number',
                              ),
                              validator: (value) => value.isEmpty
                                  ? 'Enter Your Phone Nummber..'
                                  : null,
                              initialValue: user.phoneNamber ?? '',
                              onChanged: (value) => _phoneNumber = value,
                              cursorColor: Theme.of(context).primaryColor,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: 'Male',
                                groupValue: _radioGender,
                                onChanged: (inValue) => setState(
                                  () => _radioGender = inValue,
                                ),
                                activeColor: Theme.of(context).primaryColor,
                              ),
                              Text('Male'),
                              Radio(
                                value: 'Female',
                                groupValue: _radioGender,
                                onChanged: (inValue) => setState(
                                  () => _radioGender = inValue,
                                ),
                                activeColor: Theme.of(context).primaryColor,
                              ),
                              Text('Female'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: WidthButton(
                        width: size.width,
                        title: 'Update',
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            await _userServices
                                .updateUserData(
                              userName: _name ?? user.userName,
                              phoneNumber: _phoneNumber ?? user.phoneNamber,
                              sallerCompanyName:
                                  _sallerCompanyName ?? user.sallerCompanyName,
                              userEmail: _email ?? user.userEmail,
                              userAddress: _address ?? user.userAddress,
                              userGender: _radioGender ?? user.userGender,
                            )
                                .whenComplete(() {
                              setState(() => loading = false);
                              Navigator.pop(context);
                            });
                          }
                        },
                        loading: loading,
                      ),
                    ),
                    Align(
                      child: WidthButton(
                        width: size.width,
                        onTap: () => _auth.signOutWithGoogle(context),
                        title: 'Sign Out',
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Edit',
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Theme.of(context).primaryColor),
      ),
      centerTitle: true,
    );
  }
}

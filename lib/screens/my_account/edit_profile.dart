import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/services/user_services.dart';
import 'package:market_place/widgets/width_button.dart';

class EditMyAccount extends StatefulWidget {
  final UserModel userModel;
  EditMyAccount(this.userModel);
  @override
  _EditMyAccountState createState() => _EditMyAccountState();
}

class _EditMyAccountState extends State<EditMyAccount> {
  final UserServices _userServices = UserServices();
  // a global key for the stat of the form
  final _formKey = GlobalKey<FormState>();

  String userName;
  String userEmail;
  String userAddress;
  String userGender;
  String phoneNumber;
  String sallerCompanyName;
  String radioGender;

  bool loading;

  @override
  void initState() {
    loading = false;
    radioGender = widget?.userModel?.userGender ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: textFaildDecoration,
                    child: TextFormField(
                      decoration: inputDecoration.copyWith(
                        hintText: 'Your Company Name',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Enter Your Company Name' : null,
                      initialValue: widget.userModel.sallerCompanyName ?? '',
                      onChanged: (value) => sallerCompanyName = value,
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: textFaildDecoration,
                    child: TextFormField(
                      decoration: inputDecoration.copyWith(
                        hintText: 'Your Name',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Enter Your Name..' : null,
                      initialValue: widget.userModel.userName ?? '',
                      onChanged: (value) => userName = value,
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: textFaildDecoration,
                    child: TextFormField(
                      decoration: inputDecoration.copyWith(
                        hintText: 'Your Email',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Enter Your Email..' : null,
                      initialValue: widget.userModel.userEmail ?? '',
                      onChanged: (value) => userEmail = value,
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: textFaildDecoration,
                    child: TextFormField(
                      decoration: inputDecoration.copyWith(
                        hintText: 'Address',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Enter Your Address..' : null,
                      initialValue: widget.userModel.userAddress ?? '',
                      onChanged: (value) => userAddress = value,
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: textFaildDecoration,
                    child: TextFormField(
                      decoration: inputDecoration.copyWith(
                        hintText: 'Phone Number',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Enter Your Phone Nummber..' : null,
                      initialValue: widget.userModel.phoneNamber ?? '',
                      onChanged: (value) => phoneNumber = value,
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 'Male',
                        groupValue: radioGender,
                        onChanged: (inValue) => setState(
                          () => radioGender = inValue,
                        ),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      Text('Male'),
                      Radio(
                        value: 'Female',
                        groupValue: radioGender,
                        onChanged: (inValue) => setState(
                          () => radioGender = inValue,
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
                      userName: userName ?? widget.userModel.userName,
                      phoneNumber: phoneNumber ?? widget.userModel.phoneNamber,
                      sallerCompanyName: sallerCompanyName ??
                          widget.userModel.sallerCompanyName,
                      userEmail: userEmail ?? widget.userModel.userEmail,
                      userAddress: userAddress ?? widget.userModel.userAddress,
                      userGender: radioGender ?? widget.userModel.userGender,
                    )
                        .whenComplete(
                      () {
                        setState(() => loading = false);
                        Navigator.pop(context);
                      },
                    );
                  }
                },
                loading: loading,
              ),
            ),
          ],
        ),
      ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/screens/cart/cart.dart';
import 'package:market_place/services/user_services.dart';
import 'package:market_place/widgets/width_button.dart';

class Details extends StatefulWidget {
  final UserModel userModel;
  Details(this.userModel);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final UserServices _userServices = UserServices();
  // a global key for the stat of the form
  final _formKey = GlobalKey<FormState>();

  String userName;
  String userEmail;
  String userAddress;
  String userGender;
  String phoneNumber;
  String radioGender;

  bool loading;

  @override
  void initState() {
    radioGender = widget?.userModel?.userGender ?? '';
    super.initState();
  }

  void updateUserData() async {
    if (_formKey.currentState.validate()) {
      UserModel userModel = UserModel(
        userName: userName ?? widget.userModel.userName,
        userGender: radioGender ?? widget.userModel.userGender,
        userEmail: userEmail ?? widget.userModel.userEmail,
        phoneNamber: phoneNumber ?? widget.userModel.phoneNamber,
      );
      setState(() => loading = true);
      await _userServices.updateUserData(userModel).whenComplete(() {
        setState(() => loading = false);
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          'Datails',
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
        titleSpacing: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.search_rounded), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => Cart()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: WidthButton(title: 'Update', onTap: updateUserData),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.all(18.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'User Name',
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                        labelText: 'User Name',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        icon: Icon(Icons.person),
                        contentPadding: const EdgeInsets.all(12.0),
                      ),
                      validator: (value) => value.isEmpty ? 'This Field Can\'t be Empty!' : null,
                      initialValue: widget.userModel.userName ?? '',
                      onChanged: (value) => userName = value,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                        labelText: 'Email Address',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        icon: Icon(Icons.alternate_email_rounded),
                        contentPadding: const EdgeInsets.all(12.0),
                      ),
                      validator: (value) => value.isEmpty ? 'This Field Can\'t be Empty!' : null,
                      initialValue: widget.userModel.userEmail ?? '',
                      onChanged: (value) => userEmail = value,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                        labelText: 'Phone Number',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        icon: Icon(Icons.phone),
                        contentPadding: const EdgeInsets.all(12.0),
                      ),
                      initialValue: widget.userModel.phoneNamber ?? '',
                      validator: (value) => value.isEmpty ? 'This Field Can\'t be Empty!' : null,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => phoneNumber = value,
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: RadioListTile(
                            title: Text('Mail'),
                            value: 'Male',
                            groupValue: radioGender,
                            onChanged: (inValue) => setState(() => radioGender = inValue),
                            activeColor: Theme.of(context).accentColor,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: RadioListTile(
                            title: Text('Female'),
                            value: 'Female',
                            groupValue: radioGender,
                            onChanged: (inValue) => setState(() => radioGender = inValue),
                            activeColor: Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          loading == true
              ? Container(
                  color: Colors.black38.withOpacity(0.6),
                  child: Center(child: CircularProgressIndicator()),
                )
              : Container(),
        ],
      ),
    );
  }
}

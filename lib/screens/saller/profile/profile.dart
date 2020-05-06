import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/user.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:market_place/widgets/width_button.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user = User();
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  String id;
  bool loading;

  String name;
  String companyName;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Profile'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: StreamBuilder<User>(
        stream:
            userCollection.document(id).snapshots().map(user.getCurrentUser),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Loading(color: Theme.of(context).primaryColor)
              : Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(12.0),
                        decoration: textFaildDecoration,
                        child: TextFormField(
                          decoration: inputDecoration.copyWith(
                            hintText: 'Edit Your Company Name..',
                          ),
                          validator: (value) => value.isEmpty
                              ? 'Enter your company name ..'
                              : null,
                          onChanged: (value) => companyName = value,
                          initialValue: snapshot?.data?.companyName ?? '',
                          cursorColor: Theme.of(context).primaryColor,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(12.0),
                        decoration: textFaildDecoration,
                        child: TextFormField(
                          decoration: inputDecoration.copyWith(
                            hintText: 'Name',
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Enter your name ..' : null,
                          initialValue: snapshot?.data?.name ?? '',
                          onChanged: (value) => name = value,
                          cursorColor: Theme.of(context).primaryColor,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(12.0),
                        decoration: textFaildDecoration,
                        child: TextFormField(
                          decoration: inputDecoration,
                          enabled: false,
                          initialValue: snapshot.data.email,
                          cursorColor: Theme.of(context).primaryColor,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      WidthButton(
                        title: 'Update',
                        width: size.width,
                        loading: loading,
                        onTap: () async {
                          if (formKey.currentState.validate()) {
                            setState(() => loading = true);
                            print(name);
                            print(companyName);
                            user
                                .updateUser(
                                  snapshot.data.id,
                                  name ?? snapshot.data.name,
                                  companyName ?? snapshot.data.companyName,
                                )
                                .whenComplete(
                                  () => setState(() {
                                    loading = false;
                                    Fluttertoast.showToast(
                                      msg: 'Profile Updated',
                                    );
                                  }),
                                );
                          }
                        },
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }

  loadUser() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    setState(() => id = firebaseUser.uid);
  }
}

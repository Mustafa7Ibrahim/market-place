import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/widgets/width_button.dart';

class EditInfo extends StatefulWidget {
  final String name;
  final String email;
  final String gender;

  EditInfo({this.name, this.email, this.gender});

  @override
  _EditInfoState createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  String _name;

  String _email;

  String _gender;

  var _radioGender;

  @override
  void initState() {
    _radioGender = widget.gender ?? null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CANCEL'),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Form(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: textFaildDecoration,
                  child: TextFormField(
                    decoration: inputDecoration.copyWith(
                      hintText: 'Your Name',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Enter Your Name ..' : null,
                    initialValue: widget.name ?? '',
                    onChanged: (value) => _name = value,
                    cursorColor: Theme.of(context).primaryColor,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: textFaildDecoration,
                  child: TextFormField(
                    decoration: inputDecoration.copyWith(
                      hintText: 'Your Email',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Enter Your Email ..' : null,
                    initialValue: widget.email ?? '',
                    onChanged: (value) => _email = value,
                    cursorColor: Theme.of(context).primaryColor,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: _radioGender,
                        onChanged: (inValue) => setState(
                          _radioGender = inValue,
                        ),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      Text('Male'),
                      Spacer(),
                      Radio(
                        value: 2,
                        groupValue: _radioGender,
                        onChanged: (inValue) => setState(
                          _radioGender = inValue,
                        ),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      Text('Female'),
                    ],
                  ),
                ),
                WidthButton(width: size.width, onTap: () {}, title: 'Update')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

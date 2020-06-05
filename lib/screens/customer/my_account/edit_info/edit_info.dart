import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/customer_user.dart';
import 'package:market_place/services/customer_services.dart';
import 'package:market_place/widgets/width_button.dart';

class EditInfo extends StatefulWidget {
  final CustomerUser customer;

  EditInfo({this.customer});

  @override
  _EditInfoState createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  final CustomerServices _customerServices = CustomerServices();
  // a global key for the stat of the form
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _email;
  String _address;
  String _phoneNumber;

  var _radioGender;
  bool loading;

  @override
  void initState() {
    loading = false;
    _radioGender = widget.customer.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      bottomSheet: WidthButton(
        width: size.width,
        title: 'Update',
        onTap: () async {
          if (_formKey.currentState.validate()) {
            setState(() => loading = true);
            await _customerServices
                .updateCustomerInfo(
              widget.customer.customerId,
              _name ?? widget.customer.customerName,
              _address ?? widget.customer.address,
              _phoneNumber ?? widget.customer.phoneNamber,
              widget.customer.customerImg,
              _radioGender ?? widget.customer.gender,
              _email ?? widget.customer.email,
              widget.customer.type,
            )
                .whenComplete(() {
              setState(() => loading = false);
              Navigator.pop(context);
            });
          }
        },
        loading: loading,
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
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
                        value.isEmpty ? 'Enter Your Name..' : null,
                    initialValue: widget.customer.customerName ?? '',
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
                        value.isEmpty ? 'Enter Your Email..' : null,
                    initialValue: widget.customer.email ?? '',
                    onChanged: (value) => _email = value,
                    cursorColor: Theme.of(context).primaryColor,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: textFaildDecoration,
                  child: TextFormField(
                    decoration: inputDecoration.copyWith(
                      hintText: 'Address',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Enter Your Address..' : null,
                    initialValue: widget.customer.address ?? '',
                    onChanged: (value) => _address = value,
                    cursorColor: Theme.of(context).primaryColor,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: textFaildDecoration,
                  child: TextFormField(
                    decoration: inputDecoration.copyWith(
                      hintText: 'Phone Number',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Enter Your Phone Nummber..' : null,
                    initialValue: widget.customer.phoneNamber ?? '',
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
        ],
      ),
    );
  }
}

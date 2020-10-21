import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/constant/toast.dart';
import 'package:market_place/models/address_model.dart';
import 'package:market_place/screens/cart/cart.dart';
import 'package:market_place/services/address_services.dart';
import 'package:market_place/widgets/width_button.dart';

class AddNewAddress extends StatefulWidget {
  final AddressModel addressModel;

  const AddNewAddress(this.addressModel);
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool loading;

  String userName;

  String stNum;

  String additionalInfo;

  String city;

  String phoneNumber;

  void addAddress() {
    if (_globalKey.currentState.validate()) {
      setState(() => loading = true);

      AddressModel addressData = AddressModel(
        userName: userName,
        stNum: stNum,
        additionalInfo: additionalInfo,
        city: city,
        phoneNumber: phoneNumber,
      );

      AddressServices().addNewAddress(addressData).whenComplete(() {
        setState(() => loading = false);
        Navigator.pop(context);
      }).catchError((onError) {
        setState(() => loading = false);
        showToast(context, "$onError");
      });
    }
  }

  void updateAddress() {
    if (_globalKey.currentState.validate()) {
      setState(() => loading = true);

      AddressModel addressData = AddressModel(
        id: widget.addressModel.id,
        userName: userName ?? widget.addressModel.userName,
        stNum: stNum ?? widget.addressModel.stNum,
        additionalInfo: additionalInfo ?? widget.addressModel.additionalInfo,
        city: city ?? widget.addressModel.city,
        phoneNumber: phoneNumber ?? widget.addressModel.phoneNumber,
      );

      AddressServices().updateAddress(addressData).whenComplete(() {
        setState(() => loading = false);
        Navigator.pop(context);
      }).catchError((onError) {
        setState(() => loading = false);
        showToast(context, "$onError");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          'New Address',
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
      bottomNavigationBar: WidthButton(
        onTap: widget.addressModel == null ? addAddress : updateAddress,
        title: widget.addressModel == null ? 'SAVE' : 'update',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _globalKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                margin: EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'User Name',
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                        labelText: 'Name',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        icon: Icon(Icons.person),
                        contentPadding: const EdgeInsets.all(12.0),
                      ),
                      initialValue:
                          widget.addressModel == null ? null : widget.addressModel.userName,
                      validator: (value) => value.isEmpty ? 'This Field Can\'t be Empty!' : null,
                      keyboardType: TextInputType.text,
                      onChanged: (value) => userName = value,
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'St.name/Building numbeer/Apartment number',
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                        labelText: 'St.name/Building numbeer/Apartment number',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        icon: Icon(Icons.business),
                        contentPadding: const EdgeInsets.all(12.0),
                      ),
                      initialValue: widget.addressModel == null ? null : widget.addressModel.stNum,
                      validator: (value) => value.isEmpty ? 'This Field Can\'t be Empty!' : null,
                      keyboardType: TextInputType.text,
                      onChanged: (value) => stNum = value,
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Additional Info',
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                        labelText: 'Additional Info',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        icon: Icon(Icons.mode_rounded),
                        contentPadding: const EdgeInsets.all(12.0),
                      ),
                      initialValue:
                          widget.addressModel == null ? null : widget.addressModel.additionalInfo,
                      validator: (value) => value.isEmpty ? 'This Field Can\'t be Empty!' : null,
                      keyboardType: TextInputType.text,
                      onChanged: (value) => additionalInfo = value,
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'City',
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                        labelText: 'City',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        icon: Icon(Icons.location_city_rounded),
                        contentPadding: const EdgeInsets.all(12.0),
                      ),
                      initialValue: widget.addressModel == null ? null : widget.addressModel.city,
                      validator: (value) => value.isEmpty ? 'This Field Can\'t be Empty!' : null,
                      keyboardType: TextInputType.text,
                      onChanged: (value) => city = value,
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
                      initialValue:
                          widget.addressModel == null ? null : widget.addressModel.phoneNumber,
                      validator: (value) => value.isEmpty ? 'This Field Can\'t be Empty!' : null,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => phoneNumber = value,
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

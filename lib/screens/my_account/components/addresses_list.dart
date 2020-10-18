import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/address_model.dart';
import 'package:market_place/screens/cart/cart.dart';
import 'package:market_place/services/address_services.dart';
import 'package:market_place/widgets/width_button.dart';

import 'add_new_address.dart';
import 'address_tile.dart';

class AddressesBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          'My Addresses',
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
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => AddNewAddress(null)),
        ),
        title: 'ADD NEW ADDRESS',
      ),
      body: StreamBuilder<List<AddressModel>>(
        stream: AddressServices().getListOfAddress,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return AddressTile(snapshot.data[index]);
              },
            );
          }
        },
      ),
    );
  }
}

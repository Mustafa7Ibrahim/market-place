import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/address_model.dart';
import 'package:market_place/screens/my_account/components/add_new_address.dart';
import 'package:market_place/widgets/hover_effect.dart';

class AddressTile extends StatelessWidget {
  const AddressTile(this.addressModel);

  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    return HoverEffect(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => AddNewAddress(addressModel)),
      ),
      child: Container(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(addressModel.userName, style: Theme.of(context).textTheme.headline6),
                Text(addressModel.stNum),
                Text(addressModel.city),
                Text(addressModel.phoneNumber),
              ],
            ),
            Icon(Icons.edit_outlined),
          ],
        ),
      ),
    );
  }
}

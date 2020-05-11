import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/widgets/row_edit.dart';

import 'info_row.dart';

class Address extends StatelessWidget {
  const Address({
    Key key,
    @required this.size,
    @required this.name,
    @required this.address,
    @required this.phoneNumber,
  }) : super(key: key);

  final Size size;
  final String name;
  final String address;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        boxShadow: [shadow],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: <Widget>[
          RowEdit(
            iconRow: Icons.person_pin_circle,
            onTap: () {},
            title: 'Home',
          ),
          InfoRow(
            size: size,
            title: 'Name',
            info: name,
          ),
          InfoRow(
            size: size,
            title: 'Address',
            info: address ?? 'Address',
          ),
          InfoRow(
            size: size,
            title: 'Mobile Number',
            info: phoneNumber ?? 'Phone Number',
          )
        ],
      ),
    );
  }
}

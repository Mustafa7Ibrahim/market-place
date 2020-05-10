import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        boxShadow: [shadow],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Theme.of(context).primaryColor,
                size: 20.0,
              ),
              SizedBox(width: 4.0),
              Text('Home'),
              Spacer(),
              FlatButton(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.edit,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'Edit',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ],
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

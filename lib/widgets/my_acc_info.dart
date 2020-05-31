import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/widgets/row_edit.dart';

import 'info_row.dart';

class MyAccountInfo extends StatelessWidget {
  const MyAccountInfo({
    Key key,
    this.customerName,
    this.email,
    this.gender,
    this.size,
    this.onTap,
  }) : super(key: key);

  final String customerName;
  final String email;
  final String gender;
  final Function onTap;

  final Size size;

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RowEdit(
            title: 'Personal Information',
            iconRow: Icons.person,
            onTap: onTap,
          ),
          SizedBox(
            height: 12.0
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$customerName \n',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '$email',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.0),
          InfoRow(
            size: size,
            title: 'Gender',
            info: gender ?? 'Gender',
          )
        ],
      ),
    );
  }
}

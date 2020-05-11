import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/screens/customer/my_account/edit_info/edit_info.dart';
import 'package:market_place/widgets/row_edit.dart';

import 'info_row.dart';

class MyAccountInfo extends StatelessWidget {
  const MyAccountInfo({
    Key key,
    this.customerName,
    this.email,
    this.gender,
    this.size,
  }) : super(key: key);

  final String customerName;
  final String email;
  final String gender;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowEdit(
            title: 'Personal Information',
            iconRow: Icons.person,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => EditInfo(),
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$customerName \n',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextSpan(
                  text: email,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
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

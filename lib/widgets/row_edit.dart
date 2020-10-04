import 'package:flutter/material.dart';

class RowEdit extends StatelessWidget {
  const RowEdit({@required this.title, @required this.iconRow, @required this.onTap});

  final String title;
  final IconData iconRow;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          iconRow,
          color: Theme.of(context).accentColor,
          size: 20.0,
        ),
        SizedBox(width: 4.0),
        Text(title),
      ],
    );
  }
}

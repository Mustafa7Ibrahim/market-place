import 'package:flutter/material.dart';

class RowEdit extends StatelessWidget {
  const RowEdit({
    Key key,
    @required this.title,
    @required this.iconRow,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final IconData iconRow;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          iconRow,
          color: Theme.of(context).primaryColor,
          size: 20.0,
        ),
        SizedBox(width: 4.0),
        Text(title),
        Spacer(),
        FlatButton(
          onPressed: onTap,
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
    );
  }
}

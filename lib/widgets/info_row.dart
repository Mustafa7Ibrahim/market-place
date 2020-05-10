import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    Key key,
    @required this.size,
    this.info,
    this.title,
  }) : super(key: key);

  final Size size;
  final String info;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 6.0,
            vertical: 4.0,
          ),
          width: size.width / 4,
          child: Text(
            title,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
          child: Text(
            info,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        )
      ],
    );
  }
}


import 'package:flutter/material.dart';

class WidthButton extends StatelessWidget {
  const WidthButton({
    Key key,
    @required this.width,
    @required this.onTap,
    @required this.title,
  }) : super(key: key);

  final double width;
  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: width,
      height: 54,
      child: RaisedButton(
        color: Color.fromRGBO(84, 52, 214, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onTap,
      ),
    );
  }
}

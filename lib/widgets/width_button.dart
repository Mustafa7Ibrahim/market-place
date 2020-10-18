import 'package:flutter/material.dart';

class WidthButton extends StatelessWidget {
  const WidthButton({@required this.onTap, @required this.title});

  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(12.0),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Text(title, style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
        onPressed: onTap,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class WidthButton extends StatelessWidget {
  const WidthButton({
    @required this.width,
    @required this.onTap,
    @required this.title,
    this.loading,
  });

  final bool loading;
  final double width;
  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: width,
      child: RaisedButton(
        padding: EdgeInsets.all(12.0),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: loading == true
            ? CircularProgressIndicator()
            : Text(title, style: TextStyle(color: Colors.white)),
        onPressed: onTap,
      ),
    );
  }
}

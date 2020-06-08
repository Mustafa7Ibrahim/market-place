import 'package:flutter/material.dart';

import 'loading.dart';

class WidthButton extends StatelessWidget {
  const WidthButton({
    Key key,
    @required this.width,
    @required this.onTap,
    @required this.title,
    this.loading,
  }) : super(key: key);

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: loading == true
            ? Loading(
                color: Colors.white,
                height: 54,
                width: width,
              )
            : Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
        onPressed: onTap,
      ),
    );
  }
}

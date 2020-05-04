import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final Color color;
  Loading({@required this.color});
  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: color,
      size: 54,
    );
  }
}

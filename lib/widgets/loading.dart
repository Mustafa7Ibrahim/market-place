import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  Loading({@required this.color, @required this.height, @required this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: SpinKitDoubleBounce(
        color: color,
        size: 54,
      ),
    );
  }
}

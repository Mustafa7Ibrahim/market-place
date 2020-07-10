import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';

class CategoreItem extends StatelessWidget {
  const CategoreItem({
    Key key,
    this.onTap,
    this.image,
    this.lable,
    this.imageHeight,
  });

  final Function onTap;
  final String image;
  final String lable;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [shadow],
          color: Theme.of(context).appBarTheme.color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.0),
                topLeft: Radius.circular(12.0),
              ),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: size.width,
                height: imageHeight,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              lable,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}

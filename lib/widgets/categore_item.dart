import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';

class CategoreItem extends StatelessWidget {
  const CategoreItem({
    Key key,
    @required this.size,
    this.onTap,
    this.image,
    this.lable,
    @required this.imageHeight,
    this.sizedBoxHeight,
  }) : super(key: key);

  final Size size;
  final double imageHeight;
  final Function onTap;
  final String image;
  final String lable;
  final double sizedBoxHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          boxShadow: [shadow],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                height: imageHeight,
                width: size.width,
              ),
            ),
            SizedBox(height: sizedBoxHeight),
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

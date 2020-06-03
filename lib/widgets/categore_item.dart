import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';

class CategoreItem extends StatelessWidget {
  const CategoreItem({
    Key key,
    @required this.size,
    this.onTap,
    this.image,
    this.lable,
  }) : super(key: key);

  final Size size;
  final Function onTap;
  final String image;
  final String lable;

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
            SizedBox(
              height: 150.0,
              width: size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              lable,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

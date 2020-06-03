
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/widgets/product_overview.dart';

import 'image_network.dart';

class Item extends StatelessWidget {
  const Item({
    Key key,
    @required this.height,
    @required this.width,
    this.product,
  }) : super(key: key);

  final double height;
  final double width;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ProductOverView(product: product),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [shadow],
        ),
        child: Column(
          children: <Widget>[
            ImageNetwork(
              image: product.productImages.first,
              height: height / 3,
              width: width,
            ),
            SizedBox(height: 4.0),
            Text(
              product.productName,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Price',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  product.price,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Quantity',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  product.quantity,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

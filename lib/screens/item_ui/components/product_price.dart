import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    Key key,
    @required this.size,
    @required this.product,
  }) : super(key: key);

  final Size size;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: size.width * 0.3,
        height: 38,
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.color,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0)),
        ),
        child: Center(child: Text('\$${product.price}')),
      ),
    );
  }
}

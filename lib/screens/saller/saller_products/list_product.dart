import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/product.dart';

class ListProduct extends StatelessWidget {
  final Product product;
  ListProduct({@required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [shadow]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.network(
            NetworkImage(product.productImages[0]).url,
            fit: BoxFit.fill,
          ),
          Text(product.productName),
          Text(product.price),
          Text(product.quantity),
        ],
      ),
    );
  }
}

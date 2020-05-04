import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';

class ListProduct extends StatelessWidget {
  final Product product;
  ListProduct({@required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          radius: 28.0,
          backgroundImage: NetworkImage(product.productImages[0]),
        ),
        title: Text(product.productName),
        subtitle: Text(product.price),
        trailing: Text(product.quantity),
      ),
    );
  }
}

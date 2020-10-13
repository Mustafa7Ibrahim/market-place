import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/item_ui/components/add_to_cart.dart';

class ProductDeteles extends StatelessWidget {
  const ProductDeteles({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.companyName, style: Theme.of(context).textTheme.overline),
          SizedBox(height: 12.0),
          Text(product.productName, style: Theme.of(context).textTheme.headline6),
          SizedBox(height: 4.0),
          Text(
            '\$${product.price}',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          SizedBox(height: 12.0),
          AddToCartAndBuy(product),
          SizedBox(height: 12.0),
          Text('Description', style: Theme.of(context).textTheme.caption),
          SizedBox(height: 12.0),
          Text(
            product.description,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}

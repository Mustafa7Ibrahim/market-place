
import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/cart_model.dart';

import 'image_network.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key key,
    this.cart,
  }) : super(key: key);

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        boxShadow: [shadow],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: <Widget>[
          ImageNetwork(
            image: cart.itemImg,
            width: 75,
            height: 75,
          ),
          SizedBox(width: 14.0),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  cart.itemName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: 4.0),
                Row(
                  children: <Widget>[
                    Text(
                      'Saller By.',
                      style: Theme.of(context).textTheme.overline,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      cart.sallerName ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  cart.numberOfItems,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(height: 4.0),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              cart.itemPrice,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

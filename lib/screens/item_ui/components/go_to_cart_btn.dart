import 'package:flutter/material.dart';
import 'package:market_place/screens/cart/cart.dart';

class GoToCartBTN extends StatelessWidget {
  const GoToCartBTN({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Theme.of(context).appBarTheme.color,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cart()),
          ),
        ),
      ),
    );
  }
}

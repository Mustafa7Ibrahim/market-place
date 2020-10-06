import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';

import 'components/add_to_cart.dart';
import 'components/go_to_cart_btn.dart';
import 'components/list_of_image_horizontal.dart';
import 'components/product_deteles.dart';
import 'components/product_price.dart';

class ItemUi extends StatelessWidget {
  final Product product;

  ItemUi({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.6,
            child: Stack(
              children: [
                ListOfImageHorizontal(product: product, size: size),
                SafeArea(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: BackButton(color: Theme.of(context).appBarTheme.color)),
                ),
                GoToCartBTN(),
                ProductPrice(size: size, product: product)
              ],
            ),
          ),
          ProductDeteles(product: product)
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: AddToCartAndBuy(),
      ),
    );
  }
}

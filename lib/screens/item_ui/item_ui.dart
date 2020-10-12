import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
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
      // appBar: CustomAppBar(size.height * 0.1, false),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.4,
              child: Stack(
                children: [
                  ListOfImageHorizontal(product: product, size: size),
                  ProductPrice(size: size, product: product)
                ],
              ),
            ),
            ProductDeteles(product: product)
          ],
        ),
      ),
    );
  }
}

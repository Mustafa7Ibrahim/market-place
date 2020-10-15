import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/cart/cart.dart';
import 'components/list_of_image_horizontal.dart';
import 'components/product_deteles.dart';

class ItemUi extends StatelessWidget {
  final Product product;

  ItemUi({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          'M-Place',
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
        titleSpacing: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.search_rounded), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => Cart()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.5,
              child: Stack(
                children: [
                  ListOfImageHorizontal(product: product, size: size),
                  Positioned(
                    right: 12.0,
                    top: 12.0,
                    child: IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                  )
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

import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/widgets/list_of_images.dart';
import 'package:market_place/widgets/width_button.dart';

class ProductOverView extends StatelessWidget {
  final Product product;
  ProductOverView({this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.productName,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              //TODO add the function for that
              // here when the user click it add to the cart
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: size.height / 2,
              child: ListOfImages(
                height: size.height,
                width: size.width,
                images: product.productImages,
                onTap: () {},
              ),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                product.productName,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                product.price,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            WidthButton(
              width: size.width,
              onTap: () {},
              title: 'ADD TO THE CART',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sold By ',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    TextSpan(
                      text: '${product.companyName}',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Overview',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.6)),
              ),
            ),
            SizedBox(height: 6.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(product.description),
            ),
            SizedBox(height: 12.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Spacification',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.6)),
              ),
            ),
            SizedBox(height: 6.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(product.specification),
            )
          ],
        ),
      ),
    );
  }
}

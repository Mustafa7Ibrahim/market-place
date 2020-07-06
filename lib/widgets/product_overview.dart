import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/customer/cart/cart.dart';
import 'package:market_place/services/cart_services.dart';
import 'package:market_place/widgets/list_of_images.dart';
import 'package:market_place/widgets/width_button.dart';

class ProductOverView extends StatefulWidget {
  final Product product;
  ProductOverView({this.product});

  @override
  _ProductOverViewState createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {
  CartServices _cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.productType,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => Cart(),
              ),
            ),
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
              width: size.width,
              child: ListOfImages(
                images: widget.product.productImages,
                onTap: () {},
              ),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.product.productName,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.product.price,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            WidthButton(
              width: size.width,
              onTap: () => _cartServices.addNewItemToCart(
                itemId: widget.product.productId,
                itemImg: widget.product.productImages.first,
                numberOfItems: 1,
                itemName: widget.product.productName,
                itemPrice: widget.product.price,
                sallerName: widget.product.companyName,
              ),
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
                      text: '${widget.product.companyName}',
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
              child: Text(widget.product.description),
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
              child: Text(widget.product.specification),
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}

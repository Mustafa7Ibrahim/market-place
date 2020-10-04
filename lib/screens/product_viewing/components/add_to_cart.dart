import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/constant/toast.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/cart/cart.dart';
import 'package:market_place/services/cart_services.dart';

class AddToCartAndBuy extends StatelessWidget {
  const AddToCartAndBuy({this.cartServices, this.product});

  final CartServices cartServices;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 18.0),
          height: 50,
          width: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: Theme.of(context).accentColor),
          ),
          child: IconButton(
            icon: Icon(
              Icons.add_shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              cartServices.addNewItemToCart(
                itemId: product.productId,
                itemImg: product.productImages.first,
                numberOfItems: 1,
                itemName: product.productName,
                itemPrice: product.price,
                sallerName: product.companyName,
              );
              showToast(context, 'Add to cart');
            },
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 50,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cartServices.addNewItemToCart(
                  itemId: product.productId,
                  itemImg: product.productImages.first,
                  numberOfItems: 1,
                  itemName: product.productName,
                  itemPrice: product.price,
                  sallerName: product.companyName,
                );
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Cart(),
                  ),
                );
              },
              child: Text(
                'Buy Now',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

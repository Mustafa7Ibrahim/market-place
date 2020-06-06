import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/services/cart_services.dart';
import 'package:market_place/widgets/product_overview.dart';

import 'image_network.dart';

class Item extends StatefulWidget {
  Item({
    Key key,
    @required this.size,
    this.product,
  }) : super(key: key);

  final Size size;
  final Product product;

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool taped;

  CartServices _cartServices = CartServices();

  @override
  void initState() {
    taped = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ProductOverView(product: widget.product),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [shadow],
        ),
        child: Row(
          children: <Widget>[
            ImageNetwork(
              image: widget.product.productImages.first,
              height: widget.size.height / 7,
              width: widget.size.height / 7,
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    widget.product.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    widget.product.productType,
                    style: Theme.of(context)
                        .textTheme
                        .overline
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        widget.product.price,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      Spacer(),
                      addToCartButton(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconButton addToCartButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.add_shopping_cart,
        color: taped == false ? Colors.black26 : Theme.of(context).primaryColor,
      ),
      onPressed: () {
        if (taped == false) {
          _cartServices.addNewItemToCart(
            itemId: widget.product.productId,
            itemImg: widget.product.productImages.first,
            numberOfItems: 1,
            itemName: widget.product.productName,
            itemPrice: widget.product.price,
            sallerName: widget.product.companyName,
          );
          setState(
            () {
              taped = true;
              Fluttertoast.showToast(
                msg: '${widget.product.productName} Added',
              );
            },
          );
        } else {
          _cartServices.removeItemFromCart(itemId: widget.product.productId);
          setState(
            () {
              taped = false;
              Fluttertoast.showToast(
                msg: '${widget.product.productName} removed',
              );
            },
          );
        }
      },
    );
  }
}

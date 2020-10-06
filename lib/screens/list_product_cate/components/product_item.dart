import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/constant/toast.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/services/cart_services.dart';

import '../../../widgets/loading.dart';

class ProductItem extends StatefulWidget {
  ProductItem({@required this.size, this.product});
  final Size size;
  final Product product;

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool taped = false;
  CartServices _cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              widget.product.productImages.first,
              fit: BoxFit.cover,
              height: size.height,
              width: size.width,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : Loading(color: Theme.of(context).primaryColor);
              },
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.product.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 4.0),
                Text(
                  widget.product.productType,
                  style: Theme.of(context).textTheme.caption,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${widget.product.price}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(18.0),
                        boxShadow: [shadow],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        color: Theme.of(context).appBarTheme.color,
                        onPressed: addToCart,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void addToCart() {
    final User currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      showToast(context, 'Please Sign in first!');
      return;
    }
    if (taped == false) {
      _cartServices.addNewItemToCart(
        itemId: widget.product.productId,
        itemImg: widget.product.productImages.first,
        numberOfItems: 1,
        itemName: widget.product.productName,
        itemPrice: widget.product.price,
        sallerName: widget.product.companyName,
      );
      setState(() {
        taped = true;
        showToast(context, '${widget.product.productName} Added');
      });
    } else {
      _cartServices.removeItemFromCart(itemId: widget.product.productId);
      setState(() {
        taped = false;
        showToast(context, '${widget.product.productName} removed');
      });
    }
  }
}

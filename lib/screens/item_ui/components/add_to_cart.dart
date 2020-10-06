import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/constant/toast.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/item_ui/components/cart_counter.dart';
import 'package:market_place/services/cart_services.dart';

class AddToCartAndBuy extends StatelessWidget {
  const AddToCartAndBuy({this.cartServices, this.product});

  final CartServices cartServices;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(thickness: 2),
        Row(
          children: <Widget>[
            CartCounter(),
            SizedBox(width: 12.0),
            Expanded(
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
                  showToast(context, 'Add to cart');
                },
                child: Text(
                  'Add to cart',
                  style: TextStyle(color: Theme.of(context).appBarTheme.color, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import '../../../widgets/loading.dart';

class ProductItem extends StatefulWidget {
  ProductItem({this.product});
  final Product product;

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool taped = false;
  // CartServices _cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.3,
              child: Image.network(
                widget.product.productImages.first,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : Loading(color: Theme.of(context).primaryColor);
                },
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.product.productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${widget.product.price}',
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18.0),
              ),
            ),
          ],
        ),
        Positioned(
          right: 4.0,
          top: 4.0,
          child: IconButton(
              icon: Icon(
                taped ? Icons.favorite : Icons.favorite_outline_rounded,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                setState(() => taped = !taped);
              }),
        )
      ],
    );
  }

  // void addToCart() {
  //   final User currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser == null) {
  //     showToast(context, 'Please Sign in first!');
  //     return;
  //   }
  //   if (taped == false) {
  //     _cartServices.addNewItemToCart(
  //       itemId: widget.product.productId,
  //       itemImg: widget.product.productImages.first,
  //       numberOfItems: 1,
  //       itemName: widget.product.productName,
  //       itemPrice: widget.product.price,
  //       sallerName: widget.product.companyName,
  //     );
  //     setState(() {
  //       taped = true;
  //       showToast(context, '${widget.product.productName} Added');
  //     });
  //   } else {
  //     _cartServices.removeItemFromCart(itemId: widget.product.productId);
  //     setState(() {
  //       taped = false;
  //       showToast(context, '${widget.product.productName} removed');
  //     });
  //   }
  // }
}

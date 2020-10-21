import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/constant/toast.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/models/wish_list_model.dart';
import 'package:market_place/services/wishlist_services.dart';

class ProductItem extends StatefulWidget {
  ProductItem({this.product, @required this.size});
  final Product product;
  final Size size;

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool taped = false;

  void addToWishList() {
    final User currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      showToast(context, 'Please Sign in first!');
      return;
    }
    WishListModel wishListModel = WishListModel(
      itemId: widget.product.productId,
      itemImg: widget.product.productImages.first,
      itemName: widget.product.productName,
      itemPrice: widget.product.price,
      sallerName: widget.product.companyName,
    );
    WishListServices().addItemToWishList(wishListModel).whenComplete(() {
      setState(() => taped = !taped);
      showToast(
        context,
        '${widget.product.productName} is sucsessfuly add to WishList.',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width * 0.4,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Image.network(
                    widget.product.productImages.first,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      return loadingProgress == null
                          ? child
                          : Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  widget.product.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '\$${widget.product.price}',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 18.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0.0,
            top: 0.0,
            child: IconButton(
              icon: Icon(
                taped ? Icons.favorite : Icons.favorite_outline_rounded,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: addToWishList,
            ),
          )
        ],
      ),
    );
  }
}

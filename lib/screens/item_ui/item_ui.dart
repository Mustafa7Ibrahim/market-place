import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/models/wish_list_model.dart';
import 'package:market_place/screens/cart/cart.dart';
import 'package:market_place/services/wishlist_services.dart';
import 'components/list_of_image_horizontal.dart';
import 'components/product_deteles.dart';

class ItemUi extends StatefulWidget {
  final Product product;

  ItemUi({Key key, this.product}) : super(key: key);

  @override
  _ItemUiState createState() => _ItemUiState();
}

class _ItemUiState extends State<ItemUi> {
  bool taped = false;

  void addToWishList(BuildContext context) {
    final User currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
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
    });
  }

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
                  ListOfImageHorizontal(product: widget.product, size: size),
                  Positioned(
                    right: 12.0,
                    top: 12.0,
                    child: IconButton(
                      icon: Icon(
                        taped ? Icons.favorite : Icons.favorite_outline_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => addToWishList(context),
                    ),
                  )
                ],
              ),
            ),
            ProductDeteles(product: widget.product)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:market_place/constant/toast.dart';
import 'package:market_place/models/wish_list_model.dart';
import 'package:market_place/services/cart_services.dart';
import 'package:market_place/services/wishlist_services.dart';

class WishListTile extends StatelessWidget {
  final WishListModel wishListModel;

  const WishListTile(this.wishListModel);

  void addToCart(BuildContext context) {
    CartServices()
        .addNewItemToCart(
      itemId: wishListModel.itemId,
      itemImg: wishListModel.itemImg,
      numberOfItems: 1,
      itemName: wishListModel.itemName,
      itemPrice: wishListModel.itemPrice,
      sallerName: wishListModel.sallerName,
    )
        .then((v) {
      removeItemFormWishList();
      showToast(context, '${wishListModel.itemName} Added to your cart.');
    });
  }

  void removeItemFormWishList() {
    WishListServices().removeItemFormWishList(wishListModel.itemId);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ListTile(
      contentPadding: const EdgeInsets.all(18.0),
      leading: Image.network(
        wishListModel.itemImg,
        fit: BoxFit.contain,
        width: width * 0.2,
        loadingBuilder: (context, child, loadingProgress) {
          return loadingProgress == null ? child : Center(child: CircularProgressIndicator());
        },
      ),
      title: Text(wishListModel.itemName),
      subtitle: Text(
        '\$${wishListModel.itemPrice}',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.delete_forever_rounded,
              color: Colors.redAccent,
            ),
            onPressed: removeItemFormWishList,
          ),
          IconButton(
            icon: Icon(
              Icons.add_shopping_cart,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => addToCart(context),
          ),
        ],
      ),
    );
  }
}

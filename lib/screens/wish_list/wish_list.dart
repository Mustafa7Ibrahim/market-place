import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/wish_list_model.dart';
import 'package:market_place/screens/cart/cart.dart';
import 'package:market_place/screens/wish_list/components/wish_list_tile.dart';
import 'package:market_place/services/wishlist_services.dart';

class WishList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My WishList',
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
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
      body: StreamBuilder<List<WishListModel>>(
        stream: WishListServices().getWishList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return WishListTile(snapshot.data[index]);
              },
            );
          }
        },
      ),
    );
  }
}

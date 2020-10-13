import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/cart_model.dart';

class CartServices {
  final User currentUser = FirebaseAuth.instance.currentUser;

  removeItemFromCart({@required String itemId}) async {
    final path = userCollection.doc(currentUser.uid).collection('cart').doc(itemId);
    final item = await path.get();
    if (item.exists)
      return await item.reference.delete();
    else
      return null;
  }

  reduceitemNumber({
    String itemId,
    String itemName,
    String itemImg,
    String sallerName,
    String itemPrice,
    int numberOfItems,
  }) async {
    final path = userCollection.doc(currentUser.uid).collection('cart').doc(itemId);

    final item = await path.get();

    if (item.exists == true) {
      return await path.update({
        'userId': currentUser.uid,
        'itemId': itemId,
        'itemName': itemName,
        'itemImg': itemImg,
        'itemPrice': itemPrice,
        'numberOfItems': item.data()['numberOfItems'] - 1,
        'sallerName': sallerName,
      });
    } else {
      return null;
    }
  }

  addNewItemToCart({
    String itemId,
    String itemName,
    String itemImg,
    String sallerName,
    String itemPrice,
    int numberOfItems,
  }) async {
    if (currentUser == null) return;
    final path = userCollection.doc(currentUser.uid).collection('cart').doc(itemId);

    final item = await path.get();

    if (item.exists == true) {
      return await path.update({
        'userId': currentUser.uid,
        'itemId': itemId,
        'itemName': itemName,
        'itemImg': itemImg,
        'itemPrice': itemPrice,
        'numberOfItems': item.data()['numberOfItems'] + 1,
        'sallerName': sallerName,
      });
    } else {
      return await path.set({
        'userId': currentUser.uid,
        'itemId': itemId,
        'itemName': itemName,
        'itemImg': itemImg,
        'itemPrice': itemPrice,
        'numberOfItems': numberOfItems,
        'sallerName': sallerName,
      });
    }
  }

  List<CartModel> cartListMap(QuerySnapshot snapshot) {
    return snapshot.docs.map((i) {
      return CartModel(
        userId: i.data()['userId'],
        itemId: i.data()['itemId'],
        itemName: i.data()['itemName'],
        itemPrice: i.data()['itemPrice'],
        itemImg: i.data()['itemImg'],
        numberOfItems: i.data()['numberOfItems'],
        sallerName: i.data()['sallerName'],
      );
    }).toList();
  }

  Stream<List<CartModel>> get cartProducts {
    if (currentUser == null) {
      return null;
    }
    return userCollection.doc(currentUser.uid).collection('cart').snapshots().map(cartListMap);
  }
}

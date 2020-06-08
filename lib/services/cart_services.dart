import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartServices {
  String currentUserId;

  getCurrentUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    currentUserId = sharedPreferences.getString('user');
    // return the current user id
    return currentUserId;
  }

  removeItemFromCart({@required String itemId}) async {
    await getCurrentUserId();
    final path = cartCollection
        .document(currentUserId)
        .collection('MyCart')
        .document(itemId);

    final item = await path.get();

    if (item.exists) {
      return await item.reference.delete();
    } else {
      return null;
    }
  }

  reduceitemNumber({
    String itemId,
    String itemName,
    String itemImg,
    String sallerName,
    String itemPrice,
    int numberOfItems,
  }) async {
    await getCurrentUserId();

    final path = cartCollection
        .document(currentUserId)
        .collection('MyCart')
        .document(itemId);

    final item = await path.get();
  
    if (item.exists == true) {
      return await path.updateData(
        {
          'userId': currentUserId,
          'itemId': itemId,
          'itemName': itemName,
          'itemImg': itemImg,
          'itemPrice': itemPrice,
          'numberOfItems': item.data['numberOfItems'] - 1,
          'sallerName': sallerName,
        },
      );
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
    await getCurrentUserId();

    final path = cartCollection
        .document(currentUserId)
        .collection('MyCart')
        .document(itemId);

    final item = await path.get();

    if (item.exists == true) {
      return await path.updateData(
        {
          'userId': currentUserId,
          'itemId': itemId,
          'itemName': itemName,
          'itemImg': itemImg,
          'itemPrice': itemPrice,
          'numberOfItems': item.data['numberOfItems'] + 1,
          'sallerName': sallerName,
        },
      );
    } else {
      return await path.setData(
        {
          'userId': currentUserId,
          'itemId': itemId,
          'itemName': itemName,
          'itemImg': itemImg,
          'itemPrice': itemPrice,
          'numberOfItems': numberOfItems,
          'sallerName': sallerName,
        },
      );
    }
  }

  List<CartModel> cartListMap(QuerySnapshot snapshot) {
    return snapshot.documents.map((i) {
      return CartModel(
        userId: i.data['userId'],
        itemId: i.data['itemId'],
        itemName: i.data['itemName'],
        itemPrice: i.data['itemPrice'],
        itemImg: i.data['itemImg'],
        numberOfItems: i.data['numberOfItems'],
        sallerName: i.data['sallerName'],
      );
    }).toList();
  }
}

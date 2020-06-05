import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartServices {
  String currentUserId;

  getCurrentUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString('user'));
    currentUserId = sharedPreferences.getString('user');
    // return the current user id
    return currentUserId;
  }

  addNewItemToCart({
    String itemId,
    String itemName,
    String itemImg,
    String sallerName,
    String itemPrice,
    String numberOfItems,
  }) async {
    await getCurrentUserId();
    print(currentUserId);
    return await cartCollection
        .document(currentUserId)
        .collection('MyCart')
        .document()
        .setData(
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

  List<CartModel> cartListMap(QuerySnapshot snapshot) {
    return snapshot.documents.map((i) {
      return CartModel(
        userId: i.data['userId'],
        itemId: i.data['itemId'],
        itemName: i.data['itemName'],
        itemPrice: i.data['itemPrice'],
        itemImg: i.data['itemImg'],
        numberOfItems: i.data['numberOfItems'],
        sallerName: i.data['sllerName'],
      );
    }).toList();
  }

  // Stream<List<Product>> get cartList {
  //   getCurrentUserId();
  //   return cartCollection
  //       .document(currentUserId)
  //       .collection('MyCart')
  //       .snapshots()
  //       .map(cartListMap);
  // }
}

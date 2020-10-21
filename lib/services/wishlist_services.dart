import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/wish_list_model.dart';

class WishListServices {
  final User currentUser = FirebaseAuth.instance.currentUser;

  Future addItemToWishList(WishListModel wishListModel) async {
    if (currentUser == null) return;
    final path =
        userCollection.doc(currentUser.uid).collection('wishList').doc(wishListModel.itemId);

    return await path.set(
      {
        'userId': currentUser.uid,
        'itemId': wishListModel.itemId,
        'itemName': wishListModel.itemName,
        'itemImg': wishListModel.itemImg,
        'itemPrice': wishListModel.itemPrice,
        'sallerName': wishListModel.sallerName,
      },
    );
  }

  Future removeItemFormWishList(String itemId) async {
    if (currentUser == null) return;
    final path = userCollection.doc(currentUser.uid).collection('wishList').doc(itemId);
    final item = await path.get();
    if (item.exists)
      return await item.reference.delete();
    else
      return null;
  }

  List<WishListModel> mapWIshList(QuerySnapshot snapshot) {
    return snapshot.docs.map((i) {
      return WishListModel(
        userId: i.data()['userId'],
        itemId: i.data()['itemId'],
        itemName: i.data()['itemName'],
        itemPrice: i.data()['itemPrice'],
        itemImg: i.data()['itemImg'],
        sallerName: i.data()['sallerName'],
      );
    }).toList();
  }

  Stream<List<WishListModel>> get getWishList {
    if (currentUser == null) return null;
    return userCollection.doc(currentUser.uid).collection('wishList').snapshots().map(mapWIshList);
  }
}

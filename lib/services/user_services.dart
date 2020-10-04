import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/user_model.dart';

class UserServices {
  final User currentUser = FirebaseAuth.instance.currentUser;

  Future addNewUser({
    String userId,
    String userName,
    String userEmail,
    String userImg,
    String userAddress,
    String userGender,
    String phoneNumber,
    String sallerCompanyName,
  }) async {
    // get the correct data path
    final path = userCollection.doc(userId);
    // get the snapshot of this user
    final user = await path.get();

    /*
      if this user alredy exists as a customer or saller
      then update his data to be both customer and saller
    */
    if (user.exists == true) {
      return path.update({'userId': userId});

      /*
      if it is not exists we add a new document with a new user data
    */
    } else {
      return await path.set({
        'userId': userId,
        'userName': userName,
        'userEmail': userEmail,
        'userImg': userImg,
        'userAddress': userAddress,
        'userGender': userGender,
        'PhoneNumber': phoneNumber,
        'sallerCompanyName': sallerCompanyName,
      });
    }
  }

  // this function is to update the user data
  Future updateUserData({
    String userName,
    String userEmail,
    String userAddress,
    String userGender,
    String phoneNumber,
    String sallerCompanyName,
  }) async {
    // when it get the current user id we path it to get the correct document
    return await userCollection.doc(currentUser.uid).update({
      'userName': userName,
      'userEmail': userEmail,
      'userAddress': userAddress,
      'userGender': userGender,
      'PhoneNumber': phoneNumber,
      'sallerCompanyName': sallerCompanyName,
    });
  }

  UserModel getUserData(DocumentSnapshot snapshot) {
    return UserModel(
      userId: snapshot?.data()['userId'] ?? '',
      userName: snapshot?.data()['userName'] ?? '',
      userEmail: snapshot?.data()['userEmail'] ?? '',
      userImg: snapshot?.data()['userImg'] ?? '',
      userAddress: snapshot?.data()['userAddress'] ?? '',
      userGender: snapshot?.data()['userGender'] ?? '',
      phoneNamber: snapshot?.data()['PhoneNumber'] ?? '',
      sallerCompanyName: snapshot?.data()['sallerCompanyName'] ?? '',
    );
  }

  Stream<UserModel> get currentUserData {
    return userCollection.doc(currentUser.uid).snapshots().map(getUserData);
  }
}

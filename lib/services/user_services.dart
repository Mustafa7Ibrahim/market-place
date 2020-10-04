import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  String currentUserId;

  getCurrentUserId() async {
    // get the current user id if the user is alredy loged in
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    currentUserId = sharedPreferences.getString('user');
    // return the current user id
    return currentUserId;
  }

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
    final path = userCollection.document(userId);
    // get the snapshot of this user
    final user = await path.get();

    /*
      if this user alredy exists as a customer or saller
      then update his data to be both customer and saller
    */
    if (user.exists == true) {
      return path.updateData({
        'userId': userId,
      });

      /*
      if it is not exists we add a new document with a new user data
    */
    } else {
      return await path.setData({
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
    // first calling getCurrentUserId function to get his id
    await getCurrentUserId();
    // when it get the current user id we path it to get the correct document
    return await userCollection.document(currentUserId).updateData({
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
      userId: snapshot?.data['userId'] ?? '',
      userName: snapshot?.data['userName'] ?? '',
      userEmail: snapshot?.data['userEmail'] ?? '',
      userImg: snapshot?.data['userImg'] ?? '',
      userAddress: snapshot?.data['userAddress'] ?? '',
      userGender: snapshot?.data['userGender'] ?? '',
      phoneNamber: snapshot?.data['PhoneNumber'] ?? '',
      sallerCompanyName: snapshot?.data['sallerCompanyName'] ?? '',
    );
  }

  Stream<UserModel> get currentUserData {
    getCurrentUserId();
    return userCollection.document(currentUserId).snapshots().map(getUserData);
  }
}

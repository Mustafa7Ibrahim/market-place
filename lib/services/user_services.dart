import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/user_model.dart';

class UserServices {
  final User currentUser = FirebaseAuth.instance.currentUser;

  Future addNewUser(UserModel userModel) async {
    final path = userCollection.doc(userModel.userId);

    return await path.set({
      'userId': userModel.userId,
      'userName': userModel.userName,
      'userEmail': userModel.userEmail,
      'userImg': userModel.userImg,
      'userGender': userModel.userGender,
      'PhoneNumber': userModel.phoneNamber,
    });
  }

  Future updateUserData(UserModel userModel) async {
    return await userCollection.doc(currentUser.uid).update({
      'userName': userModel.userName,
      'userEmail': userModel.userEmail,
      'userGender': userModel.userGender,
      'PhoneNumber': userModel.phoneNamber,
    });
  }

  UserModel getUserData(DocumentSnapshot snapshot) {
    return UserModel(
      userId: snapshot?.data()['userId'] ?? '',
      userName: snapshot?.data()['userName'] ?? '',
      userEmail: snapshot?.data()['userEmail'] ?? '',
      userImg: snapshot?.data()['userImg'] ?? '',
      userGender: snapshot?.data()['userGender'] ?? '',
      phoneNamber: snapshot?.data()['PhoneNumber'] ?? '',
    );
  }

  Future<UserModel> get currentUserData {
    if (currentUser != null)
      return userCollection.doc(currentUser.uid).get().then(getUserData);
    else
      return null;
  }
}

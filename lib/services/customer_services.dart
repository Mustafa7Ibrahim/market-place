import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/customer_user.dart';

class CustomerServices {

  Future addNewUser({
    String customerId,
    String customerName,
    String email,
    String userImg,
    String type,
  }) async {
    return await userCollection.document(customerId).setData({
      'customertId': customerId,
      'customerName': customerName,
      'email': email,
      'customerImg': userImg,
      'type': type,
    });
  }

  Future updateCustomerInfo(
    String customerId,
    String customerName,
    String address,
    String phoneNamber,
    String customerImg,
    String gender,
    String email,
    String type,
  ) async {
    return await userCollection.document(customerId).updateData({
      'customertId': customerId,
      'customerName': customerName,
      'address': address,
      'phoneNamber': phoneNamber,
      'customerImg': customerImg,
      'gender': gender,
      'email': email,
      'type': type,
    });
  }

  CustomerUser getCurrentUser(DocumentSnapshot documentSnapshot) {
    return CustomerUser(
      customerId: documentSnapshot.data['customertId'] ?? '',
      customerName: documentSnapshot.data['customerName'] ?? '',
      address: documentSnapshot.data['address'],
      phoneNamber: documentSnapshot.data['phoneNamber'],
      customerImg: documentSnapshot.data['customerImg'] ?? ' ',
      gender: documentSnapshot.data['gender'] ?? '',
      email: documentSnapshot.data['email'] ?? '',
      type: documentSnapshot.data['type'] ?? '',
    );
  }
}

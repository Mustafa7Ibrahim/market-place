import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:market_place/models/address_model.dart';

class AddressServices {
  final User currentUser = FirebaseAuth.instance.currentUser;

  Future addNewAddress(AddressModel address) async {
    final path = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('addresses')
        .doc();

    return path.set({
      'userId': currentUser.uid,
      'userName': address.userName,
      'stNum': address.stNum,
      'additionalInfo': address.additionalInfo,
      'city': address.city,
      'phoneNumber': address.phoneNumber,
    });
  }

  Future updateAddress(AddressModel address) async {
    final path = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('addresses')
        .doc(address.id);

    final addressData = await path.get();

    if (addressData.exists) {
      return path.update({
        'userId': address.userId,
        'userName': address.userName,
        'stNum': address.stNum,
        'additionalInfo': address.additionalInfo,
        'city': address.city,
        'phoneNumber': address.phoneNumber,
      });
    }
  }

  Future deleteAddress(String addressId) async {
    final path = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('addresses')
        .doc(addressId);
    final address = await path.get();

    if (address.exists) {
      return path.delete();
    }
  }

  List<AddressModel> listOfAddress(QuerySnapshot snapshot) {
    List<AddressModel> listOfAddresses = snapshot.docs
        .map((address) => AddressModel(
              id: address.id,
              userName: address.data()['userName'],
              userId: address.data()['userId'],
              stNum: address.data()['stNum'],
              city: address.data()['city'],
              phoneNumber: address.data()['phoneNumber'],
              additionalInfo: address.data()['additionalInfo'],
            ))
        .toList();

    return listOfAddresses;
  }

  Stream<List<AddressModel>> get getListOfAddress {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('addresses')
        .snapshots()
        .map(listOfAddress);
  }
}

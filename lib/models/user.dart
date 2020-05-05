import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final CollectionReference userCollection =
    Firestore.instance.collection('users');

final FirebaseAuth auth = FirebaseAuth.instance;

class User {
  String id;
  String name;
  String email;
  String userImg;
  String type;
  String companyName;

  User({
    this.id,
    this.name,
    this.email,
    this.userImg,
    this.type,
    this.companyName,
  });

  Future addNewUser(
    String id,
    String name,
    String email,
    String userImg,
    String type,
  ) async {
    return await userCollection.document(id).setData({
      'id': id,
      'name': name,
      'email': email,
      'userImg': userImg,
      'type': type,
    });
  }

  Future updateUser(
    String id,
    String name,
    String companyName,
  ) async {
    return await userCollection.document(id).setData({
      'id': id,
      'name': name,
      'companyName': companyName,
    });
  }

  User getCurrentUser(DocumentSnapshot documentSnapshot) {
    return User(
      id: documentSnapshot.data['id'] ?? '',
      name: documentSnapshot.data['name'] ?? '',
      email: documentSnapshot.data['email'] ?? '',
      userImg: documentSnapshot.data['userImg'] ?? ' ',
      type: documentSnapshot.data['type'] ?? '',
      companyName: documentSnapshot.data['companyName'] ?? '',
    );
  }
}

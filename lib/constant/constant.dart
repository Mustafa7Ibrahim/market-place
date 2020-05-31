import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference productCollection =
    Firestore.instance.collection('product');

final CollectionReference userCollection =
    Firestore.instance.collection('users');

List<String> types = <String>[
  'Supermarket',
  'Fashion',
  'Mobile & Tablets',
  'Electronics',
  'Health & Beauty',
  'Home & Kitchen',
  'Babies',
  'Toys',
  'Appliances',
  'Sports',
  'Automotive',
  'Tools',
];

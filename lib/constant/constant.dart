import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference productCollection = Firestore.instance.collection('product');

final CollectionReference userCollection = Firestore.instance.collection('users');

final CollectionReference cartCollection = Firestore.instance.collection('cart');

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

/* 
  images that showing in the home tab 
*/
List<String> imageDeals = <String>[
  'assets/images/deal1.png',
  'assets/images/deal2.png',
  'assets/images/deal3.jpg',
  'assets/images/deal4.jpg',
  'assets/images/deal5.png'
];

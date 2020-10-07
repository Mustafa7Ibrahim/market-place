import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference productCollection = FirebaseFirestore.instance.collection('product');

final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

// images that showing in the home tab
List<String> imageDeals = <String>[
  'assets/images/deal1.png',
  'assets/images/deal2.png',
  'assets/images/deal3.jpg',
  'assets/images/deal4.jpg',
  'assets/images/deal5.png'
];

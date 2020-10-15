import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_place/models/category_model.dart';

class CategoryServices {
  List<CategoryModel> _categoryList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((category) => CategoryModel(
              id: category.id,
              lable: category.data()['lable'],
              image: category.data()['image'],
            ))
        .toList();
  }

  Stream<List<CategoryModel>> get listOfCategories {
    return FirebaseFirestore.instance.collection('Categories').snapshots().map(_categoryList);
  }

  Stream<List<CategoryModel>> get listOfCategoriesAtHome {
    return FirebaseFirestore.instance
        .collection('Categories')
        .limit(6)
        .snapshots()
        .map(_categoryList);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/product.dart';

class ProductServices {
  List<Product> productList(QuerySnapshot snapshot) {
    return snapshot.documents.map((pro) {
      return Product(
        productId: pro.documentID,
        sallerId: pro.data['sallerId'],
        productName: pro.data['productName'],
        productType: pro.data['productType'],
        price: pro.data['price'],
        quantity: pro.data['quantity'],
        description: pro.data['description'],
        specification: pro.data['specification'],
        productImages: pro.data['productImages'],
        companyName: pro.data['CompanyName'],
      );
    }).toList();
  }

  Stream<List<Product>> get productListstrm {
    return productCollection.snapshots().map(productList);
  }
}

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/product_viewing/product_viewing.dart';
import 'package:market_place/services/product_services.dart';
import 'package:market_place/widgets/item.dart';
import 'package:market_place/widgets/loading.dart';

class ListProductCategories extends StatefulWidget {
  final String productCat;
  const ListProductCategories({@required this.productCat});

  @override
  _ListProductCategoriesState createState() => _ListProductCategoriesState();
}

class _ListProductCategoriesState extends State<ListProductCategories> {
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productCat),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Product>>(
        stream: FirebaseFirestore.instance
            .collectionGroup(widget.productCat)
            .snapshots()
            .map(ProductServices().productList),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return GridView.builder(
            //   addSemanticIndexes: true,
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 12.0,
            //     mainAxisSpacing: 12.0,
            //   ),
            //   itemBuilder: (context, index) {
            //     return snapshot.data[index].productType == productCat
            //         ? Item(
            //             size: size,
            //             onTap: () {},
            //           )
            //         : Container();
            //   },
            // );
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return snapshot.data[index].productType == widget.productCat
                    ? OpenContainer(
                        onClosed: null,
                        closedColor: Theme.of(context).scaffoldBackgroundColor,
                        closedBuilder: (context, action) {
                          return Item(
                            size: size,
                            product: snapshot.data[index],
                          );
                        },
                        transitionType: _transitionType,
                        openBuilder: (context, action) {
                          return ProductViewing(product: snapshot.data[index]);
                        },
                      )
                    : Container();
              },
            );
          }
          return Loading(color: Theme.of(context).primaryColor);
        },
      ),
    );
  }
}

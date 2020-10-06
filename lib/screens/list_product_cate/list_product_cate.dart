import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/item_ui/item_ui.dart';
import 'package:market_place/services/product_services.dart';
import 'package:market_place/screens/list_product_cate/components/product_item.dart';
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
      appBar: AppBar(title: Text(widget.productCat)),
      body: StreamBuilder<List<Product>>(
        stream: FirebaseFirestore.instance
            .collectionGroup(widget.productCat)
            .snapshots()
            .map(ProductServices().productList),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.5,
              ),
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return OpenContainer(
                  transitionType: _transitionType,
                  closedColor: Theme.of(context).scaffoldBackgroundColor,
                  closedElevation: 0.6,
                  closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  closedBuilder: (context, action) {
                    return ProductItem(size: size, product: snapshot.data[index]);
                  },
                  openShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  openBuilder: (context, action) {
                    return ItemUi(product: snapshot.data[index]);
                  },
                );
              },
            );
            //
            // return ListView.builder(
            //   itemCount: snapshot.data.length,
            //   itemBuilder: (context, index) {
            //     return OpenContainer(
            //       onClosed: null,
            //       closedColor: Theme.of(context).scaffoldBackgroundColor,
            //       closedBuilder: (context, action) {
            //         return Item(
            //           size: size,
            //           product: snapshot.data[index],
            //         );
            //       },
            //       transitionType: _transitionType,
            //       openBuilder: (context, action) {
            //         return ProductViewing(product: snapshot.data[index]);
            //       },
            //     );
            //   },
            // );
          }
          return Loading(color: Theme.of(context).primaryColor);
        },
      ),
    );
  }
}

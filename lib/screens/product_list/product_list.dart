import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_place/models/category_model.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/cart/cart.dart';
import 'package:market_place/screens/item_ui/item_ui.dart';
import 'package:market_place/services/product_services.dart';

import 'components/product_item.dart';

class ListProductCategories extends StatefulWidget {
  final CategoryModel categoryModel;
  ListProductCategories({@required this.categoryModel});

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
        leading: BackButton(),
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 12.0),
              height: 28,
              width: 28,
              child: SvgPicture.network(
                widget.categoryModel.image,
                placeholderBuilder: (BuildContext context) => Center(
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
            Text(
              widget.categoryModel.lable,
              style: TextStyle(color: Theme.of(context).iconTheme.color),
            ),
          ],
        ),
        titleSpacing: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.search_rounded), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => Cart()),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: FirebaseFirestore.instance
            .collectionGroup(widget.categoryModel.lable)
            .snapshots()
            .map(ProductServices().productList),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.7,
              ),
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return OpenContainer(
                  transitionType: _transitionType,
                  closedColor: Theme.of(context).colorScheme.surface,
                  openColor: Theme.of(context).colorScheme.surface,
                  closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  closedElevation: 0.0,
                  openElevation: 0.0,
                  closedBuilder: (context, action) {
                    return ProductItem(
                      product: snapshot.data[index],
                      size: size,
                    );
                  },
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
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

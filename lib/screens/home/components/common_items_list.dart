import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/category_model.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/item_ui/item_ui.dart';
import 'package:market_place/screens/product_list/components/product_item.dart';
import 'package:market_place/services/product_services.dart';
import 'package:market_place/widgets/hover_effect.dart';

class CommonItemsList extends StatelessWidget {
  final CategoryModel categoryModel;
  final Size size;
  CommonItemsList({@required this.categoryModel, @required this.size});

  final ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: FirebaseFirestore.instance
          .collectionGroup(categoryModel.lable)
          .limit(9)
          .snapshots()
          .map(ProductServices().productList),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? SizedBox(width: size.width * 0.3, child: Center(child: CircularProgressIndicator()))
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: HoverEffect(
                      onTap: null,
                      child: OpenContainer(
                        transitionType: _transitionType,
                        closedColor: Theme.of(context).appBarTheme.color,
                        openColor: Theme.of(context).appBarTheme.color,
                        closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        closedBuilder: (context, action) => ProductItem(
                          product: snapshot.data[index],
                          size: size,
                        ),
                        openBuilder: (context, action) => ItemUi(product: snapshot.data[index]),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}

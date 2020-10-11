import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_place/models/category_model.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/item_ui/item_ui.dart';
import 'package:market_place/services/product_services.dart';
import 'package:market_place/screens/list_product_cate/components/product_item.dart';
import 'package:market_place/widgets/custom_appbar.dart';
import 'package:market_place/widgets/loading.dart';

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
      appBar: CustomAppBar(size.height * 0.1, false),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              height: size.height * 0.12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.categoryModel.lable, style: Theme.of(context).textTheme.headline5),
                  SizedBox(
                    height: 34.0,
                    width: 34.0,
                    child: SvgPicture.network(
                      widget.categoryModel.image,
                      placeholderBuilder: (BuildContext context) => Center(
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<List<Product>>(
              stream: FirebaseFirestore.instance
                  .collectionGroup(widget.categoryModel.lable)
                  .snapshots()
                  .map(ProductServices().productList),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
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
                        closedElevation: 1,
                        closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        closedBuilder: (context, action) {
                          return ProductItem(product: snapshot.data[index]);
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
                return Loading(color: Theme.of(context).primaryColor);
              },
            ),
          ],
        ),
      ),
    );
  }
}

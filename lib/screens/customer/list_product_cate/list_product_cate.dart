import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/services/product_services.dart';
import 'package:market_place/widgets/item.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:market_place/screens/customer/product_viewing/product_viewing.dart';

class ListProductCategories extends StatelessWidget {
  final String productCat;
  const ListProductCategories({@required this.productCat});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          productCat,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).accentColor),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Product>>(
        stream: ProductServices().productListstrm,
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
                return snapshot.data[index].productType == productCat
                    ? Item(
                        size: size,
                        product: snapshot.data[index],
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ProductViewing(
                              product: snapshot.data[index],
                            ),
                          ),
                        ),
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

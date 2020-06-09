import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/services/product_services.dart';
import 'package:market_place/widgets/item.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:market_place/widgets/product_overview.dart';

class ListProductCategories extends StatelessWidget {
  final String productCat;

  const ListProductCategories({
    Key key,
    @required this.productCat,
  }) : super(key: key);
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
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Product>>(
        stream: ProductServices().productListstrm,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                                builder: (context) => ProductOverView(
                                    product: snapshot.data[index]),
                              ),
                            ),)
                    : Container();
              },
            );
          }
          return Loading(
            color: Theme.of(context).primaryColor,
            height: size.height,
            width: size.width,
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/services/product_services.dart';
import 'package:market_place/widgets/item.dart';
import 'package:market_place/widgets/loading.dart';

class ListProductCategories extends StatelessWidget {
  final String productCat;

  const ListProductCategories({
    Key key,
    @required this.productCat,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          productCat,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Product>>(
        stream: ProductServices().productListstrm,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data[index].productType == productCat) {
                  return Item(
                    height: height,
                    width: width,
                    product: snapshot.data[index],
                  );
                }
                return Container();
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                childAspectRatio: width / height,
              ),
            );
          }
          return Loading(color: Theme.of(context).primaryColor);
        },
      ),
    );
  }
}

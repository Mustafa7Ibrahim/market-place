import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/saller/saller_products/list_product.dart';
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
        title: Text(productCat),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: StreamBuilder<List<Product>>(
        stream: Product().productListstrm,
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Loading(color: Theme.of(context).primaryColor)
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 3,
                    childAspectRatio: width / height,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.data[index].productType == productCat) {
                      return ListProduct(product: snapshot.data[index]);
                    } else {
                      return Center(
                        child: Text(
                          'No product',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      );
                    }
                  },
                );
        },
      ),
    );
  }
}

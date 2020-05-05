import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/saller/saller_products/list_product.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:provider/provider.dart';

class SallerProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final _productList = Provider.of<List<Product>>(context) ?? [];
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          'Products',
          style: Theme.of(context).textTheme.title.apply(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _productList != null
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                childAspectRatio: width / height,
              ),
              itemCount: _productList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListProduct(product: _productList[index]);
              },
            )
          : Loading(color: Theme.of(context).primaryColor),
    );
  }
}

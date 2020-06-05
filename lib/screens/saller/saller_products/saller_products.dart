import 'package:flutter/material.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/saller/saller_products/list_product.dart';
import 'package:market_place/services/product_services.dart';
import 'package:market_place/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SallerProducts extends StatefulWidget {
  @override
  _SallerProductsState createState() => _SallerProductsState();
}

class _SallerProductsState extends State<SallerProducts> {
  var thisUserId;
  ProductServices _productServices = ProductServices();

  @override
  void initState() {
    getuCrrentUser();
    super.initState();
  }

  getuCrrentUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('user'));
    return thisUserId = pref.getString('user');
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Product>>(
        stream: productCollection.snapshots().map(_productServices.productList),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                childAspectRatio: width / height,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data[index].sallerId == thisUserId) {
                  return ListProduct(product: snapshot.data.elementAt(index));
                }
                return Container();
              },
            );
          }
          return Loading(
            color: Theme.of(context).primaryColor,
            height: height,
            width: width,
          );
        },
      ),
    );
  }
}

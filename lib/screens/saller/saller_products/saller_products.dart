import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/screens/saller/add_new_product/add_new_product.dart';
import 'package:market_place/services/product_services.dart';
import 'package:market_place/widgets/item.dart';
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
    final size = MediaQuery.of(context).size;
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
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return snapshot.data[index].sallerId == thisUserId
                    ? Item(
                        size: size,
                        product: snapshot.data[index],
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => AddNewProduct(
                              product: snapshot.data[index],
                            ),
                          ),
                        ),
                      )
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

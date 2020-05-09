import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/widgets/image_network.dart';
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
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: [shadow],
                        ),
                        child: Column(
                          children: <Widget>[
                            ImageNetwork(
                              image: snapshot.data[index].productImages.first,
                              height: height / 3,
                              width: width,
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              snapshot.data[index].productName,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'Price',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  snapshot.data[index].price,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'Quantity',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  snapshot.data[index].quantity,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
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

import 'package:flutter/material.dart';
import 'package:market_place/models/product.dart';
import 'package:market_place/widgets/loading.dart';

class ListOfImageHorizontal extends StatelessWidget {
  const ListOfImageHorizontal({
    Key key,
    @required this.product,
    @required this.size,
  }) : super(key: key);

  final Product product;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: PageScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: product.productImages.length,
      itemBuilder: (context, index) {
        return Image.network(
          product.productImages[index],
          fit: BoxFit.contain,
          width: size.width,
          loadingBuilder: (context, child, loadingProgress) {
            return loadingProgress == null ? child : Loading(color: Theme.of(context).primaryColor);
          },
        );
      },
    );
  }
}

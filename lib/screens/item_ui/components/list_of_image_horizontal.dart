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
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      primary: true,
      itemCount: product.productImages.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(58.0)),
          child: Image.network(
            product.productImages[index],
            fit: BoxFit.cover,
            width: size.width,
            loadingBuilder: (context, child, loadingProgress) {
              return loadingProgress == null
                  ? child
                  : Loading(color: Theme.of(context).primaryColor);
            },
          ),
        );
      },
    );
  }
}

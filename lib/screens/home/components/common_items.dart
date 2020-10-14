import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/models/category_model.dart';
import 'package:market_place/screens/product_list/product_list.dart';
import 'package:market_place/widgets/hover_effect.dart';

import 'common_items_list.dart';

class CommonItems extends StatelessWidget {
  const CommonItems({@required this.size, @required this.categoryModel});

  final Size size;
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: HoverEffect(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(categoryModel.lable),
                  Text('See more', style: TextStyle(color: Theme.of(context).primaryColor)),
                ],
              ),
            ),
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(categoryModel: categoryModel),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          height: size.height * 0.4,
          width: double.infinity,
          child: CommonItemsList(categoryModel: categoryModel, size: size),
        ),
      ],
    );
  }
}

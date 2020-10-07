import 'package:flutter/material.dart';
import 'package:market_place/widgets/categories_list_card.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        centerTitle: true,
      ),
      body: CategoriesListCard(axisCount: 2, scrollDirection: Axis.vertical, fullList: true),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:market_place/widgets/categories_list_card.dart';
import 'package:market_place/widgets/custom_appbar.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(size.height * 0.1, false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              height: size.height * 0.12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Categories', style: Theme.of(context).textTheme.headline5),
                  Icon(Icons.category_rounded),
                ],
              ),
            ),
            CategoriesListCard(true),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:market_place/widgets/categories_list_card.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: Theme.of(context).appBarTheme.color,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              height: size.height * 0.12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  Icon(
                    Icons.category_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
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

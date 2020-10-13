import 'package:flutter/material.dart';
import 'package:market_place/models/category_model.dart';
import 'package:market_place/services/category_services.dart';

import 'components/categories_list.dart';

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
                  Icon(Icons.category_rounded, color: Theme.of(context).primaryColor),
                ],
              ),
            ),
            StreamBuilder<List<CategoryModel>>(
              stream: CategoryServices().listOfCategories,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CategoriesList(snapshot: snapshot);
                } else {
                  return Center(child: LinearProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

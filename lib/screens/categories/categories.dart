import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market_place/models/category_model.dart';
import 'package:market_place/screens/cart/cart.dart';
import 'package:market_place/services/category_services.dart';

import 'components/categories_list.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          child: SvgPicture.asset(
            'assets/images/appicon.svg',
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          'Categories',
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
        leadingWidth: size.width * 0.2,
        titleSpacing: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.search_rounded), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => Cart()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // Container(
            //   alignment: Alignment.centerLeft,
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   height: size.height * 0.12,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Categories',
            //         style: Theme.of(context)
            //             .textTheme
            //             .headline6
            //             .copyWith(color: Theme.of(context).primaryColor),
            //       ),
            //       Icon(Icons.category_rounded, color: Theme.of(context).primaryColor),
            //     ],
            //   ),
            // ),
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

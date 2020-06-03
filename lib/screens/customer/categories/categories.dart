import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/screens/customer/list_product_cate/list_product_cate.dart';
import 'package:market_place/widgets/categore_item.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        children: <Widget>[
          CategoreItem(
            size: size,
            image: 'assets/images/supermarket.jpg',
            lable: 'Super Market',
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ListProductCategories(productCat: 'Supermarket'),
              ),
            ),
          ),
          CategoreItem(
            size: size,
            image: 'assets/images/fashion.jpg',
            lable: 'Fashion',
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ListProductCategories(productCat: 'Fashion'),
              ),
            ),
          ),
          CategoreItem(
            size: size,
            image: 'assets/images/mobile&tablets.jpg',
            lable: 'Mobile & Tablets',
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ListProductCategories(productCat: 'Mobile & Tablets'),
              ),
            ),
          ),
          CategoreItem(
            size: size,
            image: 'assets/images/electronics.jpg',
            lable: 'Electronics',
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ListProductCategories(productCat: 'Electronics'),
              ),
            ),
          ),
          CategoreItem(
            size: size,
            image: 'assets/images/healthandbeauty.jpg',
            lable: 'Health & Beauty',
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ListProductCategories(productCat: 'Health & Beauty'),
              ),
            ),
          ),
          CategoreItem(
            size: size,
            image: 'assets/images/houseandkitchen.jpg',
            lable: 'Home & Kitchen',
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ListProductCategories(productCat: 'Home & Kitchen'),
              ),
            ),
          ),
          CategoreItem(
            size: size,
            image: 'assets/images/babies.jpg',
            lable: 'Babies',
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ListProductCategories(productCat: 'Babies'),
              ),
            ),
          ),
          CategoreItem(
            size: size,
            image: 'assets/images/toys.jpg',
            lable: 'Toys',
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(productCat: 'Toys'),
              ),
            ),
          ),
          CategoreItem(
            size: size,
            image: 'assets/images/appliances.jpg',
            lable: 'Appliances',
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ListProductCategories(productCat: 'Appliances'),
              ),
            ),
          ),
          CategoreItem(
            size: size,
            image: 'assets/images/sports.jpg',
            lable: 'Sports',
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ListProductCategories(productCat: 'Sports'),
              ),
            ),
          ),
          CategoreItem(
            size: size,
            image: 'assets/images/automotive.jpg',
            lable: 'Automotive',
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ListProductCategories(productCat: 'Automotive'),
              ),
            ),
          ),
          CategoreItem(
            size: size,
            image: 'assets/images/tools.jpg',
            lable: 'Tools',
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ListProductCategories(productCat: 'Tools'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

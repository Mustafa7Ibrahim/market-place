import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/screens/list_product_cate/list_product_cate.dart';
import 'package:market_place/widgets/categore_item.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double imageHeight = size.height * 0.2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: <Widget>[
          CategoreItem(
            image: 'assets/images/supermarket.jpg',
            lable: 'Super Market',
            imageHeight: imageHeight,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(productCat: 'Supermarket'),
              ),
            ),
          ),
          CategoreItem(
            image: 'assets/images/fashion.jpg',
            lable: 'Fashion',
            imageHeight: imageHeight,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(productCat: 'Fashion'),
              ),
            ),
          ),
          CategoreItem(
            image: 'assets/images/mobile&tablets.jpg',
            lable: 'Mobile & Tablets',
            imageHeight: imageHeight,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(productCat: 'Mobile & Tablets'),
              ),
            ),
          ),
          CategoreItem(
            image: 'assets/images/electronics.jpg',
            lable: 'Electronics',
            imageHeight: imageHeight,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(productCat: 'Electronics'),
              ),
            ),
          ),
          CategoreItem(
            image: 'assets/images/healthandbeauty.jpg',
            lable: 'Health & Beauty',
            imageHeight: imageHeight,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(productCat: 'Health & Beauty'),
              ),
            ),
          ),
          CategoreItem(
            image: 'assets/images/houseandkitchen.jpg',
            lable: 'Home & Kitchen',
            imageHeight: imageHeight,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(productCat: 'Home & Kitchen'),
              ),
            ),
          ),
          CategoreItem(
            image: 'assets/images/babies.jpg',
            lable: 'Babies',
            imageHeight: imageHeight,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(productCat: 'Babies'),
              ),
            ),
          ),
          CategoreItem(
            image: 'assets/images/toys.jpg',
            lable: 'Toys',
            imageHeight: imageHeight,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(productCat: 'Toys'),
              ),
            ),
          ),
          CategoreItem(
            image: 'assets/images/appliances.jpg',
            lable: 'Appliances',
            imageHeight: imageHeight,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(productCat: 'Appliances'),
              ),
            ),
          ),
          CategoreItem(
            image: 'assets/images/sports.jpg',
            lable: 'Sports',
            imageHeight: imageHeight,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(productCat: 'Sports'),
              ),
            ),
          ),
          CategoreItem(
            image: 'assets/images/automotive.jpg',
            lable: 'Automotive',
            imageHeight: imageHeight,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(
                  productCat: 'Automotive',
                ),
              ),
            ),
          ),
          CategoreItem(
            image: 'assets/images/tools.jpg',
            lable: 'Tools',
            imageHeight: imageHeight,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(
                  productCat: 'Tools',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

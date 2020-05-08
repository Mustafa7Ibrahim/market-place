import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:market_place/screens/customer/list_product_cate/list_product_cate.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: textFaildDecoration,
            child: ListTile(
              leading: Icon(Icons.store_mall_directory),
              title: Text('Super Market'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListProductCategories(productCat: 'Supermarket'),
                ),
              ),
            ),
          ),
          Container(
            decoration: textFaildDecoration,
            child: ListTile(
              leading: Icon(Icons.beach_access),
              title: Text('Fashion'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListProductCategories(productCat: 'Fashion'),
                ),
              ),
            ),
          ),
          Container(
            decoration: textFaildDecoration,
            child: ListTile(
              leading: Icon(Icons.tablet_mac),
              title: Text('Mobile & Tablets'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListProductCategories(productCat: 'Mobile & Tablets'),
                ),
              ),
            ),
          ),
          Container(
            decoration: textFaildDecoration,
            child: ListTile(
              leading: Icon(Icons.tv),
              title: Text('Electronics'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListProductCategories(productCat: 'Electronics'),
                ),
              ),
            ),
          ),
          Container(
            decoration: textFaildDecoration,
            child: ListTile(
              leading: Icon(Icons.directions_bike),
              title: Text('Health & Beauty'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListProductCategories(productCat: 'Health & Beauty'),
                ),
              ),
            ),
          ),
          Container(
            decoration: textFaildDecoration,
            child: ListTile(
              leading: Icon(Icons.kitchen),
              title: Text('Home & Kitchen'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListProductCategories(productCat: 'Home & Kitchen'),
                ),
              ),
            ),
          ),
          Container(
            decoration: textFaildDecoration,
            child: ListTile(
              leading: Icon(Icons.tag_faces),
              title: Text('Babies'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListProductCategories(productCat: 'Babies'),
                ),
              ),
            ),
          ),
          Container(
            decoration: textFaildDecoration,
            child: ListTile(
              leading: Icon(Icons.videogame_asset),
              title: Text('Toys'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListProductCategories(productCat: 'Toys'),
                ),
              ),
            ),
          ),
          Container(
            decoration: textFaildDecoration,
            child: ListTile(
              leading: Icon(Icons.devices_other),
              title: Text('Appliances'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListProductCategories(productCat: 'Appliances'),
                ),
              ),
            ),
          ),
          Container(
            decoration: textFaildDecoration,
            child: ListTile(
              leading: Icon(Icons.motorcycle),
              title: Text('Sports'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListProductCategories(productCat: 'Sports'),
                ),
              ),
            ),
          ),
          Container(
            decoration: textFaildDecoration,
            child: ListTile(
              leading: Icon(Icons.adjust),
              title: Text('Automotive'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListProductCategories(productCat: 'Automotive'),
                ),
              ),
            ),
          ),
          Container(
            decoration: textFaildDecoration,
            child: ListTile(
              leading: Icon(Icons.toll),
              title: Text('Tools'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListProductCategories(productCat: 'Tools'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

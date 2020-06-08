import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/screens/customer/categories/categories.dart';
import 'package:market_place/screens/customer/list_product_cate/list_product_cate.dart';
import 'package:market_place/widgets/categore_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double imageHeight = size.width / 4;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Market Place',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Swiper(
              itemCount: imageDeals.length,
              autoplay: true,
              autoplayDelay: 5000,
              duration: 1000,
              pagination: SwiperPagination(alignment: Alignment.bottomCenter),
              control: SwiperControl(),
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  imageDeals[index],
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Text(
                  'Browse By Category ',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                onPressed: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Categories(),
                  ),
                ),
                child: Text('See All'),
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 3,
              children: <Widget>[
                CategoreItem(
                  imageHeight: imageHeight,
                  size: size / 3,
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
                  imageHeight: imageHeight,
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
                  imageHeight: imageHeight,
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
                  imageHeight: imageHeight,
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
                  imageHeight: imageHeight,
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
                  imageHeight: imageHeight,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

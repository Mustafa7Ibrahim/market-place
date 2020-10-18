import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/category_model.dart';
import 'package:market_place/screens/cart/cart.dart';
import 'package:market_place/services/category_services.dart';

import 'components/common_items.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentUser = FirebaseAuth.instance.currentUser;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: SvgPicture.asset(
            'assets/images/appicon.svg',
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          'Market Place',
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
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: size.height * 0.3,
              child: Swiper(
                itemCount: imageDeals.length,
                autoplay: true,
                autoplayDelay: 5000,
                duration: 1000,
                // pagination: SwiperPagination(alignment: Alignment.bottomCenter),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: AssetImage(imageDeals[index]),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            StreamBuilder<List<CategoryModel>>(
              stream: CategoryServices().listOfCategoriesAtHome,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return CommonItems(size: size, categoryModel: snapshot.data[index]);
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

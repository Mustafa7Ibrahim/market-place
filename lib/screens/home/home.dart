import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/category_model.dart';
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
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: size.height * 0.35,
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

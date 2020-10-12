import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/screens/categories/categories.dart';
import 'package:market_place/widgets/categories_list_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  pagination: SwiperPagination(alignment: Alignment.bottomCenter),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        image: DecorationImage(
                          image: AssetImage(imageDeals[index]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
              //       child: Text('Browse By Category'),
              //     ),
              //     FlatButton(
              //       child: Text('See All'),
              //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //       textColor: Theme.of(context).accentColor,
              //       onPressed: () => Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => Categories()),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:market_place/constant/constant.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/screens/cart/cart.dart';
import 'package:market_place/screens/categories/categories.dart';
import 'package:market_place/screens/my_account/my_account.dart';
import 'package:market_place/widgets/categories_list_card.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentUser = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyAccount()),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag_rounded),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome back ',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      currentUser?.userName == null
                          ? TextSpan(
                              text: 'in Market Palce,',
                              style: Theme.of(context).textTheme.headline6,
                            )
                          : TextSpan(
                              text: '${currentUser.userName},',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(fontSize: 24.0, color: Theme.of(context).accentColor),
                            ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
                child: Text(
                  'Fined any product what you want',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Search',
                      border: InputBorder.none,
                      fillColor: Colors.grey.withOpacity(0.2),
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                    // onChanged: (value) => sallerCompanyName = value,
                    cursorColor: Theme.of(context).accentColor,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Browse By Category'),
                  ),
                  FlatButton(
                    child: Text('See All'),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Categories()),
                    ),
                  ),
                ],
              ),
              Container(
                height: size.height * 0.4,
                child: CategoriesListCard(
                  axisCount: 3,
                  scrollDirection: Axis.vertical,
                  fullList: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_place/models/category_model.dart';
import 'package:market_place/screens/list_product_cate/list_product_cate.dart';
import 'package:market_place/services/category_services.dart';

class CategoriesListCard extends StatelessWidget {
  final bool listView;
  final CategoryServices _categoryServices = CategoryServices();

  CategoriesListCard(this.listView);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryModel>>(
      stream: _categoryServices.listOfCategories,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return listView == true
              ? CatListView(snapshot: snapshot)
              : CatGridList(snapshot: snapshot);
        } else {
          return Center(child: LinearProgressIndicator());
        }
      },
    );
  }
}

class CatListView extends StatelessWidget {
  CatListView({this.snapshot});
  final snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      itemCount: snapshot.data.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ListProductCategories(
                categoryModel: snapshot.data[index],
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: ListTile(
              title: Text(
                snapshot.data[index].lable,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              leading: SizedBox(
                height: 48.0,
                width: 48.0,
                child: SvgPicture.network(
                  snapshot.data[index].image,
                  placeholderBuilder: (BuildContext context) => Center(
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CatGridList extends StatelessWidget {
  CatGridList({@required this.snapshot});

  final snapshot;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ListProductCategories(
                categoryModel: snapshot.data[index],
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SvgPicture.network(
                  snapshot.data[index].image,
                  height: size.height * 0.2,
                  width: size.width * 0.2,
                  placeholderBuilder: (BuildContext context) => Center(
                    child: const CircularProgressIndicator(),
                  ),
                ),
                Container(
                  height: 26.0,
                  padding: EdgeInsets.all(4.0),
                  alignment: Alignment.bottomCenter,
                  width: size.width * 0.3,
                  color: Colors.white,
                  child: Text(
                    snapshot.data[index].lable,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

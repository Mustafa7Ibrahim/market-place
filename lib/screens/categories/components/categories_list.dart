import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market_place/screens/product_list/product_list.dart';
import 'package:market_place/widgets/hover_effect.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({this.snapshot});
  final snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      itemCount: snapshot.data.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: HoverEffect(
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ListProductCategories(
                  categoryModel: snapshot.data[index],
                ),
              ),
            ),
            child: ListTile(
              title: Text(
                snapshot.data[index].lable,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              leading: SizedBox(
                height: 28.0,
                width: 28.0,
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

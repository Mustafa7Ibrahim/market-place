import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:market_place/models/category_model.dart';
import 'package:market_place/screens/list_product_cate/list_product_cate.dart';
import 'package:market_place/services/category_services.dart';

class CategoriesListCard extends StatelessWidget {
  final int axisCount;
  final Axis scrollDirection;
  final bool fullList;

  final CategoryServices _categoryServices = CategoryServices();
  CategoriesListCard({@required this.axisCount, this.scrollDirection, this.fullList});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryModel>>(
      stream: _categoryServices.listOfCategories,
      builder: (context, snapshot) {
        return GridView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: scrollDirection,
          padding: EdgeInsets.all(12.0),
          shrinkWrap: true,
          itemCount: fullList ? snapshot?.data?.length ?? 0 : 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: axisCount,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
          ),
          itemBuilder: (context, index) {
            return !snapshot.hasData || snapshot.data.length == null
                ? Center(child: CircularProgressIndicator())
                : ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child: InkWell(
                      highlightColor: Colors.green,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListProductCategories(
                            productCat: snapshot.data[index].lable,
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            snapshot.data[index].image,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 26.0,
                              padding: EdgeInsets.all(4.0),
                              alignment: Alignment.bottomCenter,
                              width: double.infinity,
                              color: Theme.of(context).accentColor,
                              child: Text(
                                snapshot.data[index].lable,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(color: Theme.of(context).appBarTheme.color),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}

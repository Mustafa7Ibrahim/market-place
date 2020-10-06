import 'package:flutter/material.dart';

import 'loading.dart';

class ListOfImages extends StatelessWidget {
  const ListOfImages({
    this.images,
    this.onTap,
  });

  final Function onTap;
  final List images;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18.0)),
            child: Image.network(
              images[index],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : Loading(color: Theme.of(context).primaryColor);
              },
            ),
          ),
        );
      },
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
    );
  }
}

import 'package:flutter/material.dart';

import 'loading.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({
    Key key,
    @required this.image,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final String image;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        height: height,
        width: width,
        loadingBuilder: (context, child, loadingProgress) {
          return loadingProgress == null
              ? child
              : Loading(color: Theme.of(context).primaryColor);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'loading.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({Key key, @required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        return loadingProgress == null ? child : Loading(color: Theme.of(context).primaryColor);
      },
    );
  }
}

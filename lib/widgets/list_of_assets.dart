import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'loading.dart';

class ListOfAssets extends StatelessWidget {
  const ListOfAssets({
    this.width,
    this.index,
    this.images,
    this.onTap,
    this.height,
  });

  final double width;
  final double height;
  final Function onTap;
  final int index;
  final List<Asset> images;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Click Here to Change The Photos',
      preferBelow: false,
      showDuration: Duration(seconds: 7),
      waitDuration: Duration(seconds: 7),
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(12.0),
          width: width / 2 + 34,
          decoration: BoxDecoration(
            boxShadow: [shadow],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: AssetThumb(
              asset: images[index],
              width: 300,
              height: 300,
              spinner: Loading(
                color: Theme.of(context).primaryColor,
                height: 300,
                width: 300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
